From: Steve Ellcey <sellcey@cavium.com>
Date: Wed, 12 Apr 2017 13:04:00 -0700
Subject: [LTP] non-ascii output from mtest01?
Message-ID: <201704122004.v3CK40ZR008345@sellcey-dt.caveonetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

I was wondering if anyone else has the test mtest01 printing
out non-ascii characters.  Attached is the output from my LTP run and I
always have issues with grepping or reading the output in an editor
because of these non-ascii characters.

I looked at testcases/kernel/mem/mtest01/mtest01.c but I didn't see any
obvious source for where this output is coming from.

Steve Ellcey
sellcey@caviumnetworks.com


<<<test_start>>>
tag=mtest01 stime=1490664912
cmdline="mtest01 -p80"
contacts=""
analysis=exit
<<<test_output>>>
`¶^@^@a¶^@^@b¶^@^@c¶^@^@d¶^@^@e¶^@^@f¶^@^@g¶^@^@h¶^@^@i¶^@^@j¶^@^@k¶^@^@l¶^@^@m¶^@^@n¶^@^@o¶^@^@p¶^@^@q¶^@^@r¶^@^@s¶^@^@t¶^@^@u¶^@^@v¶^@^@w¶^@^@x¶^@^@y¶^@^@z¶^@^@{¶^@^@|¶^@^@}¶^@^@~¶^@^@^?¶^@^@<80>¶^@^@<81>¶^@^@<82>¶^@^@<83>¶^@^@<84>¶^@^@<85>¶^@^@<86>¶^@^@<87>¶^@^@<88>¶^@^@<89>¶^@^@<8a>¶^@^@<8b>¶^@^@<8c>¶^@^@<8d>¶^@^@<8e>¶^@^@<8f>¶^@^@<90>¶^@^@<91>¶^@^@<92>¶^@^@<93>¶^@^@<94>¶^@^@<95>¶^@^@<96>¶^@^@<97>¶^@^@<98>¶^@^@<99>¶^@^@<9b>¶^@^@<9d>mtest01     1  TPASS  :  212633528 kbytes allocated only.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=4
<<<test_end>>>
<<<test_start>>>
tag=mtest01w stime=1490664912
cmdline="mtest01 -p80 -w"
contacts=""
analysis=exit
<<<test_output>>>
E·^@^@F·^@^@G·^@^@H·^@^@I·^@^@J·^@^@K·^@^@L·^@^@M·^@^@N·^@^@O·^@^@P·^@^@Q·^@^@R·^@^@S·^@^@T·^@^@U·^@^@V·^@^@W·^@^@X·^@^@Y·^@^@Z·^@^@[·^@^@\·^@^@]·^@^@^·^@^@_·^@^@`·^@^@a·^@^@b·^@^@c·^@^@d·^@^@e·^@^@f·^@^@g·^@^@h·^@^@i·^@^@j·^@^@k·^@^@l·^@^@m·^@^@n·^@^@o·^@^@p·^@^@q·^@^@r·^@^@s·^@^@t·^@^@u·^@^@v·^@^@w·^@^@x·^@^@y·^@^@z·^@^@{·^@^@|·^@^@}·^@^@~·^@^@^?·^@^@<80>mtest01     1  TPASS  :  212455996 kbytes allocated and used.
<<<execution_status>>>
initiation_status="ok"
duration=8 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=6
<<<test_end>>>
