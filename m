Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUcLW-0005xG-MT
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:43:26 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUcLV-00026a-EC
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 08:43:26 +0000
Received: by pxi38 with SMTP id 38so10341105pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 00:43:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
References: <20100106185019.GA19647@us.ibm.com>
	<1262976343.20881.4.camel@moss-pluto.epoch.ncsc.mil>
	<1262976627.20881.6.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<1262988051.20881.42.camel@moss-pluto.epoch.ncsc.mil>
	<364299f41001081408sf9d740ew55dad7b542463416@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 12 Jan 2010 00:43:19 -0800
Message-ID: <364299f41001120043p41ead970ieed6188e31e3fc04@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] regression: selinux testsuite broken since October
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>, ltp-list@lists.sourceforge.net

On Mon, Jan 11, 2010 at 11:55 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>> Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > On Fri, 2010-01-08 at 23:27 -0800, Garrett Cooper wrote:
>> > > On Fri, Jan 8, 2010 at 2:08 PM, Garrett Cooper <yanegomi@gmail.com> =
wrote:
>> > > > On Fri, Jan 8, 2010 at 2:00 PM, Stephen Smalley <sds@tycho.nsa.gov=
> wrote:
>> > > >> On Fri, 2010-01-08 at 13:38 -0800, Garrett Cooper wrote:
>> > > >>> On Fri, Jan 8, 2010 at 10:50 AM, Stephen Smalley <sds@tycho.nsa.=
gov> wrote:
>> > > >>> > On Fri, 2010-01-08 at 13:47 -0500, Stephen Smalley wrote:
>> > > >>> >> On Fri, 2010-01-08 at 10:20 -0800, Garrett Cooper wrote:
>> > > >>> >> > =A0 =A0 Thanks for the feedback and details Stephen.
>> > > >>> >> > =A0 =A0 Would you be kind enough to try out the version fro=
m CVS to see
>> > > >>> >> > whether or not it resolves your issue? You'll also need to =
update
>> > > >>> >> > $LTPROOT/scripts in order to use the new version as I added=
 a distro
>> > > >>> >> > detection script which opens up /etc/redhat-release (for re=
dhat) as
>> > > >>> >> > opposed to using rpm to query the release.
>> > > >>> >> > Thanks,
>> > > >>> >> > -Garrett
>> > > >>> >>
>> > > >>> >> The attempt to make the test policy immediately dies with:
>> > > >>> >> detect_distro.sh: ERROR: Bad release file: /etc/redhat-release
>> > > >>> >
>> > > >>> > I should note that I'm running it on Fedora, so I wouldn't exp=
ect that
>> > > >>> > file to exist. =A0But the script needs to handle it gracefully=
; we just
>> > > >>> > use the generic test policy files in that situation.
>> > > >>>
>> > > >>> =A0 =A0 What does /etc/redhat-release look like (feel free to re=
ply to me off-list)?
>> > > >>
>> > > >> On RHEL5, it can look like one of the following:
>> > > >> Red Hat Enterprise Linux Server release 5 (Tikanga)
>> > > >> Red Hat Enterprise Linux Server release 5.x (Tikanga)
>> > > >> Red Hat Enterprise Linux Client release 5 (Tikanga)
>> > > >> Red Hat Enterprise Linux Client release 5.x (Tikanga)
>> > > >
>> > > > Interesting. They switched over to more of the Fedora-style brandi=
ng, maybe?.
>> > > >
>> > > > [garrcoop@halflife ~]$ cat /etc/redhat-release
>> > > > Red Hat Enterprise Linux AS release 4 (Nahant Update 6)
>> > >
>> > > Could you try again please :)?
>> >
>> > Fails with:
>> > cp: cannot stat
>> > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/refpolicy/p=
olicy_files/generic/test_policy.*': No such file or directory
>>
>> You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>>
>> I think we are supposed to actually be running
>> /opt/ltp/testscripts/test_selinux.sh. =A0So then the first question for
>> Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR from a
>> testscript? =A0Or should the policy sources be copied into /opt?
>
> Ok, but regardless: =A0the refpolicy Makefile is still broken.

    Yes, it is (I don't have access to that package I think on my
version of Fedora...). Please try the attached patch and let me know
how it goes [the comments aren't as important as the `set -e' and
`$(TEST_POLICY_DIR)/' removal on the cp(1) call].
Thanks,
-Garrett

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/refp=
olicy/Makefile,v
retrieving revision 1.12
diff -u -r1.12 Makefile
--- Makefile    8 Jan 2010 09:39:20 -0000       1.12
+++ Makefile    12 Jan 2010 08:40:23 -0000
@@ -69,15 +69,17 @@

 TEST_POLICY_DIR                :=3D $(TEST_POLICY_DIR)/generic

-POLICY_FILES           :=3D test_global.te $(filter-out
test_global.te,$(notdir $(wildcard $(TEST_POLICY_DIR)/*.te)))
+# This is being done to preserve precedence; test_global.te must come firs=
t.
+POLICY_FILES           :=3D test_global.te \
+                          $(filter-out test_global.te,$(notdir
$(wildcard $(TEST_POLICY_DIR)/*.te)))

 ifneq ($(CHECKPOLICY_VERS),24)
 POLICY_FILES           :=3D $(filter-out test_bounds.te,$(POLICY_FILES))
 endif

 load:
-       @if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
-           cp -p $(TEST_POLICY_DIR)/test_policy.* $(POLICY_DEVEL_DIR); \
+       @set -e; if [ -d "$(POLICY_DEVEL_DIR)" ]; then \
+           cp -p test_policy.* $(POLICY_DEVEL_DIR); \
            $(MAKE) -C $(POLICY_DEVEL_DIR) clean; \
            $(MAKE) -C $(POLICY_DEVEL_DIR) test_policy.pp; \
            $(SEMODULE) -i $(POLICY_DEVEL_DIR)/test_policy.pp; \

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
