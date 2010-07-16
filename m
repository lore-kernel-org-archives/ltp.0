Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OZtja-0002Ir-Ir
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:50:22 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OZtjZ-0005wz-Pa
	for ltp-list@lists.sourceforge.net; Fri, 16 Jul 2010 22:50:22 +0000
Received: by iwn34 with SMTP id 34so3641795iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Jul 2010 15:50:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb249e$14ed7490$3ec85db0$@co.jp>
References: <000001cb249e$14ed7490$3ec85db0$@co.jp>
Date: Fri, 16 Jul 2010 15:50:16 -0700
Message-ID: <AANLkTimgkcie9ze6ge5SmrH8Fe8a1z8RT0FgZMhjExW5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP]
	=?utf-8?b?4oCd77yj772P772O772U772B772J772O772F772S772T4oCd?=
	=?utf-8?q?_test_was_=22TFAIL=22_but_=22PASS=22_is_in_log_results?=
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jul 15, 2010 at 9:19 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> With RHEL5.4/5.5 systems, I noticed that "Containers" test failed but
> "Containers" is PASS in log results:
>
> ---<log results file>-------------
> ...
> hangup01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> Containers =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> BindMounts =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PASS =A0 =A0 =A0 0
> ...
> ----------------
>
> ---<detail in redirected file>-------------
> ...
> check_netns_enabled =A0 =A01 =A0TFAIL =A0: =A0unshare syscall smoke test =
failed:
> errno=3DEINVAL(22): Invalid argument
> Network namespaces not enabled in kernel. =A0Not running netns tests.
> ...
> ----------------
>
> The source which returned with "Invalid argument" is
> "check_netns_enabled.c":
>
> ---<check_netns_enabled.c>-------------
> main()
> {
> =A0 =A0 =A0 =A0/* Checking if the kernel supports unshare with netns capa=
bilities.
> */
> =A0 =A0 =A0 =A0if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm (TFAIL | TERRNO, "unshare syscall=
 smoke test
> failed");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0tst_exit();
> }
> ----------------
>
> In RHEL5.4/5.5 systems, unshare() does not support the argument
> "CLONE_NEWNET".
> But I feel strange that log results is "PASS" in spite of "TFAIL" exit.
>
> "container_test.sh" which calls "check_netns_enabled.c" is as follows:
> ---<container_test.sh>-------------
> ...
> check_netns_enabled
> if [ $? -eq 0 ]; then
> =A0 =A0 =A0 =A0echo "Running netns tests."
> =A0 =A0 =A0 =A0runnetnstest.sh
> else
> =A0 =A0 =A0 =A0echo "Network namespaces not enabled in kernel. =A0Not run=
ning netns
> tests."
> fi
> ...
> ----------------
>
> According to above source, "check_netns_enabled.c" is only the judgement
> whether "runnetnstest.sh" test can be called or not.
> So, I think that "TFAIL" is not suitable for the test impossibility
> message.
> "TCONF" is more suitable for the message than "TFAIL", I think.
> But, if "TCONF" is used instead of "TFAIL", "tst_exit" returns with 0.
> And the test shell "runnetnstest.sh" is called against intention.
>
>
> I thought up two ways of solutions.
> (1) Insert "exit(1)" just after "tst_resm()" of "check_netns_enabled.c"
> (2) Replace "TFAIL" with "TWARN", instead of "TCONF".
>
> But above solutions are both irregular measures, I think.
>
> If there are other good measures, please give me advice.
>
>
> In the following, I nominate a temporary patch for an example:
>
> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>
> =3D=3D=3D(1)=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/testcases/kernel/containers/netns/check_netns_enabled.c =A0 2010-07=
-12
> 02:01:45.000000000 +0900
> +++ b/testcases/kernel/containers/netns/check_netns_enabled.c =A0 2010-07=
-16
> 11:58:14.000000000 +0900
> @@ -43,7 +43,8 @@
> =A0{
> =A0 =A0 =A0 =A0/* Checking if the kernel supports unshare with netns capa=
bilities.
> */
> =A0 =A0 =A0 =A0 if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm (TFAIL | TERRNO, "unshare syscall =
smoke test
> failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm (TCONF | TERRNO, "unshare syscall =
smoke test
> failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit (1);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> =3D=3D=3D(2)=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/testcases/kernel/containers/netns/check_netns_enabled.c =A0 2010-07=
-12
> 02:01:45.000000000 +0900
> +++ b/testcases/kernel/containers/netns/check_netns_enabled.c =A0 2010-07=
-16
> 11:56:47.000000000 +0900
> @@ -43,7 +43,7 @@
> =A0{
> =A0 =A0 =A0 =A0/* Checking if the kernel supports unshare with netns capa=
bilities.
> */
> =A0 =A0 =A0 =A0 if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0=
) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm (TFAIL | TERRNO, "unshare syscall =
smoke test
> failed");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm (TWARN | TERRNO, "unshare syscall =
smoke test
> failed");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Uh, that would introduce a more serious problem because the netns
tests are keyed on whether or not that script passes or fails.

If you can provide a more stable means of detecting whether or not
CLONE_* is available with netns, and integrate that into the tests,
that would be a better idea.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
