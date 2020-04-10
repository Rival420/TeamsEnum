$teams = get-team -Archived $false
$col1 = new-object system.collections.arraylist
foreach ($team in $teams){
	$users = Get-TeamUser -GroupId $team.GroupId
	foreach ($user in $users){
		$tmp = new-object system.object
		$tmp | add-member -MemberType NoteProperty -Name "GroupName" -Value $team.DisplayName
		$tmp | add-member -Membertype NoteProperty -Name "Visibility" -value $team.Visibility
		$tmp | Add-Member -MemberType NoteProperty -Name "User" -Value $user.User
		$tmp | Add-Member -MemberType NoteProperty -Name "Role" -Value $user.Role
		
		$col1.add($tmp)
		}
	}
$col1 | export-csv -Path teammembers.csv

$col2 = new-object system.collections.arraylist
foreach ($team in $teams){
	$channels = get-teamchannel -groupid $team.groupid
	foreach ($channel in $channels){
		$tmp2 = New-Object System.Object
		$tmp2 | add-member -MemberType NoteProperty -Name "GroupName" -Value $team.DisplayName
		$tmp2 | Add-Member -MemberType NoteProperty -Name "Channel" -Value $channel.DisplayName
		$tmp2 | Add-member -Membertype NoteProperty -Name "MembershipType" -Value $channel.membershiptype
		$col2.add($tmp2)
		}
	}
$col2 | export-csv -path channels.csv

$teams = get-team -Archived $false
$col3 = new-object system.collections.arraylist
foreach ($team in $teams){
	$channels = get-teamchannel -groupid $team.groupid
	foreach ($channel in $channels){
		if ($channel.membershiptype -eq 'private'){
			$users = get-teamchanneluser -groupid $team.groupid -displayname $channel.displayname
			foreach ($user in $users){
				$tmp3 = new-object system.object
				$tmp3 | add-member -MemberType NoteProperty -Name "GroupName" -Value $team.DisplayName
				$tmp3 | add-member -membertype NoteProperty -Name "ChannelName" -Value $channel.DisplayName
				$tmp3 | Add-member -Membertype NoteProperty -Name "MembershipType" -Value $channel.membershiptype
				$tmp3 | add-member -Membertype NoteProperty -Name "Visibility" -value $team.Visibility
				$tmp3 | Add-Member -MemberType NoteProperty -Name "User" -Value $user.User
				$tmp3 | Add-Member -MemberType NoteProperty -Name "Role" -Value $user.Role
				$col3.add($tmp3)
			}
		}
	}
}
$col3 | export-csv -Path privatechannelusers.csv



