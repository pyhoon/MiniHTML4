B4A=true
Group=Classes
ModulesStructureVersion=1
Type=Class
Version=9.85
@EndOfDesignText@
#Region Shared Files
'#Macro: Title, Export as zip, ide://run?file=%B4X%\Zipper.jar&Args=%PROJECT_NAME%.zip
'#CustomBuildAction: folders ready, %WINDIR%\System32\Robocopy.exe,"..\..\Shared Files" "..\Files"
#End Region
Sub Class_Globals
	Private xui As XUI
	Private Root As B4XView
	Private obj1 As MyLibrary
End Sub

Public Sub Initialize
'	B4XPages.GetManager.LogEvents = True
End Sub

'This event will be called once, before the page becomes visible.
Private Sub B4XPage_Created (Root1 As B4XView)
	Root = Root1
	Root.LoadLayout("MainPage")
	obj1.Initialize
	If xui.IsB4A Then obj1.Name = "B4A"
	If xui.IsB4i Then obj1.Name = "B4i"
	If xui.IsB4J Then obj1.Name = "B4J"
	B4XPages.SetTitle(Me, obj1.Name)
End Sub

'You can see the list of page related events in the B4XPagesManager object. The event name is B4XPage.

Private Sub Button1_Click
	xui.MsgboxAsync($"Hello ${obj1.Name}!"$, "B4X")
End Sub