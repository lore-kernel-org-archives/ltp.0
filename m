From: Veronika Kabatova <vkabatov@redhat.com>
Date: Fri, 6 Mar 2020 07:09:58 -0500 (EST)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for=09kernel_5=2E5?=
 =?utf-8?q?=2E8-97453d9=2Ecki_=28stable=29?=
In-Reply-To: <20200306080838.GB14808@dell5510>
References: <cki.AEA99E5519.SMAFL9TDK6@redhat.com>
 <20200306080838.GB14808@dell5510>
Message-ID: <1680169507.12167032.1583496598731.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Petr Vorel" <pvorel@suse.cz>
> To: "CKI Project" <cki-project@redhat.com>
> Cc: "Linux Stable maillist" <stable@vger.kernel.org>, "LTP Mailing List" <ltp@lists.linux.it>, "Nikolai Kondrashov"
> <spbnick@gmail.com>
> Sent: Friday, March 6, 2020 9:08:38 AM
> Subject: Re: [LTP] ? FAIL: Test report for	kernel 5.5.8-97453d9.cki (stable)
> 
> Hi,
> 
> > We ran automated tests on a recent commit from this kernel tree:
> 
> >        Kernel repo:
> >        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> >             Commit: 97453d9b9b2b - Linux 5.5.8
> 
> > The results of these automated tests are provided below.
> 
> >     Overall result: FAILED (see details below)
> >              Merge: OK
> >            Compile: OK
> >              Tests: FAILED
> 
> > All kernel binaries, config files, and logs are available for download
> > here:
> 
> >   https://cki-artifacts.s3.us-east-2.amazonaws.com/index.html?prefix=datawarehouse/2020/03/05/473513
> 
> > One or more kernel tests failed:
> 
> >     s390x:
> >      ? stress: stress-ng
> >      ? LTP
> Here it's 9 syscalls failed for "slept for too long" [1]
>     28	tst_timer_test.c:310: FAIL: clock_nanosleep() slept for too long
>     12	tst_timer_test.c:310: FAIL: nanosleep() slept for too long
>     27	tst_timer_test.c:310: FAIL: poll() slept for too long
>     22	tst_timer_test.c:310: FAIL: prctl() slept for too long
>     25	tst_timer_test.c:310: FAIL: select() slept for too long
>     76	tst_timer_test.c:310: FAIL: select() slept for too long
>    126	tst_timer_test.c:310: FAIL: select() slept for too long
>     22	tst_timer_test.c:310: FAIL: futex_wait() slept for too long
>     53	tst_timer_test.c:310: FAIL: futex_wait() slept for too long
> 
> BTW it'd be interesting to see previous build. I searched for stable in jobs
> [2], but there is no linux-5.5.y (I see linux-5.4.y).
> 

We're not on the main kernelci.org page just yet. There's a staging grafana
instance with a limited set of data:

https://staging.kernelci.org:3000/d/home/home?orgId=1&var-origin=redhat&var-git_repository_url=All

We're planning the dashboard I mentioned in the previous email which should
make the discovery easier, as well as working on getting on the main
Kernel CI page. The best way right now is to check previous stable emails
by CKI Project in the archives:

https://lists.linaro.org/pipermail/linux-stable-mirror/2020-March/

These are two 5.5.y test runs from the list:

https://lists.linaro.org/pipermail/linux-stable-mirror/2020-March/174716.html
https://lists.linaro.org/pipermail/linux-stable-mirror/2020-March/174715.html

jstancek also already seems to be looking into some s390x issues which might
be related:

https://lists.linaro.org/pipermail/linux-stable-mirror/2020-March/174549.html


Veronika

> Kind regards,
> Petr
> 
> [1]
> https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/03/05/473513/s390x_2_LTP_syscalls.fail.log
> [2] https://kernelci.org/job/
> 
> 
> 

