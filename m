Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmlBp-0002ZJ-Py
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:48:25 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmlBp-0008WL-08
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:48:25 +0000
Received: by pwi5 with SMTP id 5so689319pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 01:48:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100302092116.3409.1130.sendpatchset@localhost.localdomain>
References: <20100302092116.3409.1130.sendpatchset@localhost.localdomain>
Date: Wed, 3 Mar 2010 01:48:17 -0800
Message-ID: <364299f41003030148g4a7665cfi5de1afc0768e2738@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix memcg test scripts
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
To: Sachin Sant <sachinp@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Mar 2, 2010 at 1:21 AM, Sachin Sant <sachinp@in.ibm.com> wrote:
> Inspite of memcg kernel support being available, memcg_[functional|regres=
sion
> |stress] test script fails to execute with message
>
> "Either Kernel does not support for memory resource controller or feature=
 not enabled"
> "Skipping all memcgroup testcases...."
>
> Fix the scripts to use proper if []; then .. fi statements.
>
> Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
> ---
>
> diff -Naurp a/testcases/kernel/controllers/memcg/functional/memcg_functio=
n_test.sh b/testcases/kernel/controllers/memcg/functional/memcg_function_te=
st.sh
> --- a/testcases/kernel/controllers/memcg/functional/memcg_function_test.s=
h =A0 =A0 =A02010-03-02 12:23:27.000000000 +0530
> +++ b/testcases/kernel/controllers/memcg/functional/memcg_function_test.s=
h =A0 =A0 =A02010-03-02 12:23:33.000000000 +0530
> @@ -30,8 +30,7 @@ export TCID=3D"memcg_function_test"
> =A0export TST_TOTAL=3D38
> =A0export TST_COUNT=3D0
>
> -if [ ! "grep -w memory /proc/cgroups | cut -f4" =3D=3D "1" ]
> -then
> +if [ "$(grep -w memory /proc/cgroups | cut -f4)" !=3D "1" ]; then
> =A0 =A0 =A0 =A0 echo "WARNING:";
> =A0 =A0 =A0 =A0 echo "Either Kernel does not support for memory resource =
controller or feature not enabled";
> =A0 =A0 =A0 =A0 echo "Skipping all memcgroup testcases....";
> diff -Naurp a/testcases/kernel/controllers/memcg/regression/memcg_regress=
ion_test.sh b/testcases/kernel/controllers/memcg/regression/memcg_regressio=
n_test.sh
> --- a/testcases/kernel/controllers/memcg/regression/memcg_regression_test=
.sh =A0 =A02010-03-02 12:23:27.000000000 +0530
> +++ b/testcases/kernel/controllers/memcg/regression/memcg_regression_test=
.sh =A0 =A02010-03-02 12:23:33.000000000 +0530
> @@ -35,8 +35,7 @@ if [ "$(id -ru)" !=3D 0 ]; then
> =A0 =A0 =A0 =A0exit 0
> =A0fi
>
> -if [ "$(grep -w memory /proc/cgroups | cut -f4)" !=3D "1" ]
> -then
> +if [ "$(grep -w memory /proc/cgroups | cut -f4)" !=3D "1" ]; then
> =A0 =A0 =A0 =A0tst_resm TCONF "Either memory resource controller kernel s=
upport absent"
> =A0 =A0 =A0 =A0tst_resm TCONF "or feature is not enabled; skipping all me=
mcgroup testcases."
> =A0 =A0 =A0 =A0 exit 0
> diff -Naurp a/testcases/kernel/controllers/memcg/stress/memcg_stress_test=
.sh b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh =A0 =
=A02010-03-02 12:23:27.000000000 +0530
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh =A0 =
=A02010-03-02 12:23:33.000000000 +0530
> @@ -30,8 +30,7 @@ export TCID=3D"memcg_stress_test"
> =A0export TST_TOTAL=3D2
> =A0export TST_COUNT=3D0
>
> -if [ ! "grep -w memory /proc/cgroups | cut -f4" =3D=3D "1" ]
> -then
> +if [ "$(grep -w memory /proc/cgroups | cut -f4)" !=3D "1" ]; then
> =A0 =A0 =A0 =A0 echo "WARNING:";
> =A0 =A0 =A0 =A0 echo "Either Kernel does not support for memory resource =
controller or feature not enabled";
> =A0 =A0 =A0 =A0 echo "Skipping all memcgroup testcases....";

Good catch -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
