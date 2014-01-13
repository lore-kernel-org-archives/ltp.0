Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1W2hLL-000178-0n
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 13:14:15 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1W2hLJ-0005jS-FO
	for ltp-list@lists.sourceforge.net; Mon, 13 Jan 2014 13:14:14 +0000
Date: Mon, 13 Jan 2014 08:14:05 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <257752569.438158.1389618844997.JavaMail.root@redhat.com>
In-Reply-To: <52CA960B.9080709@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
	<52CA960B.9080709@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 0/5] various tcp_cmds/ssh/* fixes, rewrites
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Jiri Jaburek" <jjaburek@redhat.com>
> To: ltp-list@lists.sourceforge.net
> Sent: Monday, 6 January, 2014 12:39:55 PM
> Subject: Re: [LTP] [PATCH 0/5] various tcp_cmds/ssh/* fixes, rewrites
> 
> On 12/03/2013 11:16 AM, Jiri Jaburek wrote:
> > Jiri Jaburek (5):
> >   ssh: unify code style amongst ssh tests
> >   ssh: remove unused ssh_set_passwd script
> >   ssh: properly create/remove user home dir, if possible
> >   ssh: try to prevent invalid PASS when remote cmd fails
> >   ssh: don't use crypt-based pre-encrypted passwords
> > 
> >  testcases/network/tcp_cmds/ssh/ssh01          | 42
> >  ++++++++++++------------
> >  testcases/network/tcp_cmds/ssh/ssh01_s1       | 39 +++++++++++++----------
> >  testcases/network/tcp_cmds/ssh/ssh02          | 39 +++++++++++------------
> >  testcases/network/tcp_cmds/ssh/ssh02_s1       | 17 +++++-----
> >  testcases/network/tcp_cmds/ssh/ssh03          | 46
> >  +++++++++++++--------------
> >  testcases/network/tcp_cmds/ssh/ssh03_s1       | 15 +++++----
> >  testcases/network/tcp_cmds/ssh/ssh_set_passwd | 28 ----------------
> >  7 files changed, 103 insertions(+), 123 deletions(-)
> >  delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_set_passwd
> > 
> 
> Could somebody review these changes, please? All patches should be well
> commented using commit messages.

Acked-by: Jan Stancek <jstancek@redhat.com>

Hi Jiri,

The patches look good to me. All applied cleanly on current latest
and I successfully ran these 3 testcases on RHEL 5.3/6.0/7Beta.

I'm adding diff of output below. Looking at sources this shouldn't matter
as I couldn't find any code actually depending on this output.

Even though the patches look simple, we are currently close to releasing
new LTP version, so I'll leave it up to Cyril, if he wants to include
this before or after.

Regards,
Jan

-----------

--- /tmp/before.txt	2014-01-13 14:11:23.828695492 +0100
+++ /tmp/after.txt	2014-01-13 14:11:33.835653955 +0100
@@ -1,9 +1,10 @@
 1.
+
 userdel: user 'ssh_usr1' does not exist
-useradd: warning: the home directory already exists.
-Not copying any file from skel directory into it.
 Creating mailbox file: File exists
-SSH Test Invalid Password 
+Changing password for user ssh_usr1.
+passwd: all authentication tokens updated successfully.
+TEST: SSH Test Invalid Password 
 spawn ssh -l ssh_usr1 localhost whoami
 ssh_usr1@localhost's password: 
 Permission denied, please try again.
@@ -14,14 +15,16 @@
 SSH would not allow ssh_usr1 to login with invalid password, Test Passed 
 
 TEST_PASSED
+userdel: /var/spool/mail/ssh_usr1 not owned by ssh_usr1, not removing
 ssh01       0  TINFO  :  Cleaning up.
 
 2.
 userdel: user 'ssh_usr2' does not exist
-useradd: warning: the home directory already exists.
-Not copying any file from skel directory into it.
+Creating mailbox file: File exists
+Changing password for user ssh_usr2.
+passwd: all authentication tokens updated successfully.
 TEST: Test to see if ssh rejects Invalid User 
-spawn ssh -l Invaild_User localhost
+spawn ssh -l Invaild_User localhost whoami
 Invaild_User@localhost's password: 
 Permission denied, please try again.
 Invaild_User@localhost's password: 
@@ -35,13 +38,13 @@
 
 3.
 userdel: user 'ssh_usr3' does not exist
-useradd: warning: the home directory already exists.
-Not copying any file from skel directory into it.
+Creating mailbox file: File exists
+Changing password for user ssh_usr3.
+passwd: all authentication tokens updated successfully.
 TEST: SSH allow (non-root) valid User 
 spawn ssh -l ssh_usr3 localhost whoami
 ssh_usr3@localhost's password: 
 ssh_usr3
-
 SSH allowed ssh_usr3 to login, Test PASSED 
 ssh03       0  TINFO  :  Cleaning up.
 

> 
> Thanks,
> Jiri
> 
> 
> ------------------------------------------------------------------------------
> Rapidly troubleshoot problems before they affect your business. Most IT
> organizations don't have a clear picture of how application performance
> affects their revenue. With AppDynamics, you get 100% visibility into your
> Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics
> Pro!
> http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
