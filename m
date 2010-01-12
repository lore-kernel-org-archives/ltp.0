Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NUk8r-00024w-Dq
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 17:02:53 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NUk8o-00056n-Vv
	for ltp-list@lists.sourceforge.net; Tue, 12 Jan 2010 17:02:53 +0000
Received: by pxi38 with SMTP id 38so10620442pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jan 2010 09:02:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
References: <364299f41001081338u37e77cd3q3d9535f3dec71331@mail.gmail.com>
	<364299f41001082327o31bbe79eh849ea1651cf12632@mail.gmail.com>
	<1263237132.5091.1.camel@moss-pluto.epoch.ncsc.mil>
	<20100111195043.GA23360@us.ibm.com>
	<1263239706.5091.11.camel@moss-pluto.epoch.ncsc.mil>
	<20100111201936.GA24711@us.ibm.com>
	<20100111205858.GA26412@us.ibm.com>
	<20100111210006.GA26554@us.ibm.com>
	<20100111213100.GA28138@us.ibm.com>
	<1263302168.14187.13.camel@moss-pluto.epoch.ncsc.mil>
Date: Tue, 12 Jan 2010 08:55:38 -0800
Message-ID: <364299f41001120855r653842d3x630cdaa6ec4129b6@mail.gmail.com>
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

On Tue, Jan 12, 2010 at 5:16 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Mon, 2010-01-11 at 15:31 -0600, Serge E. Hallyn wrote:
>> Quoting Serge E. Hallyn (serue@us.ibm.com):
>> > Quoting Serge E. Hallyn (serue@us.ibm.com):
>> > > Quoting Serge E. Hallyn (serue@us.ibm.com):
>> > > > Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> > > > > On Mon, 2010-01-11 at 13:50 -0600, Serge E. Hallyn wrote:
>> > > > > > > Fails with:
>> > > > > > > cp: cannot stat
>> > > > > > > `/home/sds/ltp/testcases/kernel/security/selinux-testsuite/r=
efpolicy/policy_files/generic/test_policy.*': No such file or directory
>> > > > > >
>> > > > > > You ran /home/sds/ltp/testscripts/test_selinux.sh, right?
>> > > > > >
>> > > > > > I think we are supposed to actually be running
>> > > > > > /opt/ltp/testscripts/test_selinux.sh. =A0So then the first que=
stion for
>> > > > > > Garrett is how should we deduce /home/sds/ltp as $LTP_SRCDIR f=
rom a
>> > > > > > testscript? =A0Or should the policy sources be copied into /op=
t?
>> > > > >
>> > > > > Ok, but regardless: =A0the refpolicy Makefile is still broken.
>> > > >
>> > > > Yup.
>> > >
>> > > All right, baby-steps.
>> > >
>> > > The attached test_selinux.diff is not to be applied, but something
>> > > like it is needed. =A0Should we have the ltp 'make install' fill in
>> > > TOP_SRCDIR in /opt/ltp/testscripts/test_selinux.sh? =A0BTW, Garrett,
>> > > that is the issue I was saying is shared between test_selinux.sh
>> > > and some others including test_robind.sh. =A0That's why I'm not just
>> > > sending a patch to make it work, bc i think we need more general
>> > > guidance.
>> > >
>> > > The second match makes the 'make load' part of test_selinux.sh
>> > > succeed on rhel5.4. =A0Stephen, how does it do on fedora?
>> > >
>> > > After loading policy it fails to execute ltp-pan, but I figure let's
>> > > get policy loading working first.
>>
>> All right well just doing
>>
>> --- /root/ltp_cvs_orig/ltp/testscripts/test_selinux.sh =A0 =A0 =A0 =A020=
09-05-19 05:39:11.000000000 -0400
>> +++ /opt/ltp/testscripts/test_selinux.sh =A0 =A0 =A02010-01-11 16:26:12.=
000000000 -0500
>> @@ -115,7 +117,7 @@
>> =A0SAVEBINTYPE=3D`ls -Zd $LTPROOT/testcases/bin | awk '{ print $4 }' | a=
wk -F: '{ print $3 }'`
>> =A0/usr/bin/chcon -t test_file_t $LTPROOT/testcases/bin
>>
>> -$LTPROOT/pan/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $=
LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $=
LTPROOT/runtest/selinux
>> +$LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/selinux -n ltp-selinux -l $=
LTPROOT/results/selinux.logfile -o $LTPROOT/results/selinux.outfile -p -f $=
LTPROOT/runtest/selinux
>>
>> =A0# cleanup before exiting
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> in test_selinux.sh makes the testsuite mostly pass (test 39 fails, all
>> up to then pass)
>>
>> Again this is on RHEL5.4.
>
> test39 isn't supposed to be run on RHEL5.4.
> The old tests/Makefile had conditional logic to exclude certain tests on
> RHEL4 and on RHEL5, as their kernels wouldn't support newer tests.


Something that fell through the cracks because I didn't take the time
to actually determine _what_ the requirements were for the tests so
they would report configuration failure instead of failure. Please try
this (I properly pasted it this time instead of using my xterm window
and paste):

Index: tests/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/selinux-testsuite/test=
s/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- tests/Makefile	9 Oct 2009 17:55:51 -0000	1.7
+++ tests/Makefile	12 Jan 2010 16:53:57 -0000
@@ -24,11 +24,26 @@

 include	$(top_srcdir)/include/mk/env_pre.mk

-RECURSIVE_TARGETS	:=3D install
+ARGS			=3D -m
+# Don't want to pass the -d option unless DESTDIR is a non-zero length str=
ing.
+ifneq ($(strip $(DESTDIR)),)
+ARGS			+=3D -d $(DESTDIR)
+endif

-include $(top_srcdir)/include/mk/generic_trunk_target.mk
+DISTRO_VER		:=3D $(shell $(top_srcdir)/scripts/detect_distro.sh $(ARGS))
+
+#
+# Certain tests should be excluded on RHEL [45].x as their kernels don't
+# support the tests.
+#
+# XXX (garrcoop): actually complete the work to add proper checks to the t=
ests
+# to report TCONF on configuration failure.
+#
+ifneq ($(findstring $(DISTRO_VER),redhat-4 redhat-5),)
+FILTER_OUT_DIRS		+=3D dyntrace dyntrans
+endif
+ifeq (redhat-4,$(DISTRO_VER))
+FILTER_OUT_DIRS		+=3D bounds
+endif

-all:
-	@set -e; for i in $(SUBDIRS); do \
-	    $(MAKE) -C $$i $@; \
-	done
+include $(top_srcdir)/include/mk/generic_trunk_target.mk

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
