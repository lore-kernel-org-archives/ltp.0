Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MeArU-0002Rz-6C
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:51:40 +0000
Received: from qw-out-1920.google.com ([74.125.92.144])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeArN-0002xj-S9
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 16:51:40 +0000
Received: by qw-out-1920.google.com with SMTP id 5so19845qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2009 09:51:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090820160731.30926.75897.sendpatchset@localhost.localdomain>
References: <20090820160655.30926.34854.sendpatchset@localhost.localdomain>
	<20090820160731.30926.75897.sendpatchset@localhost.localdomain>
Date: Thu, 20 Aug 2009 09:51:27 -0700
Message-ID: <364299f40908200951h2fed6a68gec2eace5879917ca@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] New & modified reusable functions for new & existing
	testcases
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, vaidy <svaidy@linux.vnet.ibm.com>, gautham <ego@in.ibm.com>

On Thu, Aug 20, 2009 at 9:07 AM, Poornima
Nayak<mpnayak@linux.vnet.ibm.com> wrote:
> Implemented reusable functions to learn system architecture before execut=
ing
> architecture specific testcases.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-full-20090731_orig/testcases/kernel/power_management/pm_in=
clude.sh ltp-full-20090731/testcases/kernel/power_management/pm_include.sh
> --- ltp-full-20090731_orig/testcases/kernel/power_management/pm_include.s=
h =A0 =A0 =A02009-08-20 19:59:11.000000000 +0530
> +++ ltp-full-20090731/testcases/kernel/power_management/pm_include.sh =A0=
 2009-08-20 20:29:21.000000000 +0530
> @@ -112,6 +112,46 @@ function is_multi_socket() {
> =A0 =A0 =A0 =A0fi
> =A0}
>
> +function is_multi_core() {
> + =A0 =A0 =A0 siblings=3D`cat /proc/cpuinfo | grep siblings | uniq | cut =
-f2 -d':'`
> + =A0 =A0 =A0 cpu_cores=3D`cat /proc/cpuinfo | grep "cpu cores" | uniq | =
cut -f2 -d':'`
> + =A0 =A0 =A0 echo "siblings count $siblings cores count $cpu_cores"
> + =A0 =A0 =A0 if [ $siblings -eq $cpu_cores ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $cpu_cores -gt 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : $(( num_of_cpus =3D siblings / cpu_cores =
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $num_of_cpus -gt 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 fi
> +}
> +
> +function is_dual_core() {
> + =A0 =A0 =A0 siblings=3D`cat /proc/cpuinfo | grep siblings | uniq | cut =
-f2 -d':'`
> + =A0 =A0 =A0 =A0cpu_cores=3D`cat /proc/cpuinfo | grep "cpu cores" | uniq=
 | cut -f2 -d':'`
> + =A0 =A0 =A0 =A0if [ $siblings -eq $cpu_cores ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ $cpu_cores -eq 2 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> + =A0 =A0 =A0 =A0else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: $(( num_of_cpus =3D siblings / cpu_cor=
es ))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ $num_of_cpus -eq 2 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "number of cpus $nu=
m_of_cpus"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> + =A0 =A0 =A0 =A0fi
> +}
> +
> =A0function get_kernel_version() {
> =A0 =A0 =A0 =A0# Get kernel minor version
> =A0 =A0 =A0 =A0export kernel_version=3D`uname -r | awk -F. '{print $1"."$=
2"."$3}' | cut -f1 -d'-'`
> @@ -120,42 +160,12 @@ function get_kernel_version() {
> =A0function get_valid_input() {
> =A0 =A0 =A0 =A0kernel_version=3D$1
> =A0 =A0 =A0 =A0case "$kernel_version" in
> - =A0 =A0 =A0 '2.6.29' | '2.6.30' | '2.6.31')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 export valid_input=3D"0 1 2=
" ;;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 *) export valid_input=3D"0 1" ;;
> + =A0 =A0 =A0 '2.6.26' | '2.6.27' | '2.6.28')
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 export valid_input=3D"0 1" =
;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *) export valid_input=3D"0 1 2" ;;
> =A0 =A0 =A0 =A0esac
> =A0}
>
> -function get_max_sched_mc() {
> - =A0 =A0 =A0 get_kernel_version
> - =A0 =A0 =A0 case "$kernel_version" in
> - =A0 =A0 =A0 '2.6.29' | '2.6.30' | '2.6.31')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 '2.6.26' | '2.6.27' | '2.6.28')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 *)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 esac
> -}
> -
> -function get_max_sched_smt() {
> - =A0 =A0get_kernel_version
> - =A0 =A0case "$kernel_version" in
> - =A0 =A0 =A0 =A0'2.6.29' | '2.6.30' | '2.6.31')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 2
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 =A0'2.6.26' | '2.6.27' | '2.6.28')
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 =A0*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> - =A0 =A0 =A0 esac
> -}
> -
> =A0function check_supp_wkld() {
> =A0 =A0 =A0 =A0sched_mcsmt=3D$1
> =A0 =A0 =A0 =A0work_load=3D$2
> @@ -184,58 +194,33 @@ function analyze_wrt_workload_hyperthrea
> =A0 =A0 work_load=3D$2
> =A0 =A0 pass_count=3D$3
> =A0 =A0 sched_smt=3D$4
> - =A0 =A0stress=3D$5
>
> - =A0 =A0 =A0 if [ $sched_mc > $sched_smt ]; then
> + =A0 =A0 =A0 if [ $sched_mc -gt $sched_smt ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_supp_wkld $sched_mc $work_load; vali=
d_workload=3D$?
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_supp_wkld $sched_smt $work_load; val=
id_workload=3D$?
> =A0 =A0 =A0 =A0fi
>
> - =A0 =A0 =A0 if [ "$stress" =3D "thread" ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$valid_workload" in
> - =A0 =A0 =A0 =A00)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; t=
hen
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TF=
AIL "Consolidation at core level failed for \
> -sched_mc=3D$sched_mc, sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TP=
ASS "Consolidation at core level passed for \
> -sched_mc=3D$sched_mc, sched_smt=3D$sched_smt & workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> - =A0 =A0 =A0 =A01)
> - =A0 =A0 =A0 =A0 =A0 =A0if [ $pass_count -lt 5 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS "Consolidation at core le=
vel failed for \
> -unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=3D=
$sched_smt"
> - =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TFAIL "Consolidation at core le=
vel passed for \
> -unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=3D=
$sched_smt"
> - =A0 =A0 =A0 =A0 =A0 =A0fi ;;
> - =A0 =A0 =A0 =A0esac
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$valid_workload" in
> - =A0 =A0 =A0 =A00)
> - =A0 =A0 =A0 =A0 =A0 =A0if [ $pass_count -lt 5 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TFAIL "Consolidation at package=
 level failed for \
> + =A0 =A0 =A0 case "$valid_workload" in
> + =A0 =A0 =A0 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "Consolidati=
on at package level failed for \
> =A0sched_mc=3D$sched_mc, sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS "Consolidation at package=
 level passed for \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "Consolidati=
on at package level passed for \
> =A0sched_mc=3D$sched_mc, sched_smt=3D$sched_smt & workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0fi ;;
> - =A0 =A0 =A0 =A01)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 echo "pass count is $pass_c=
ount"
> - =A0 =A0 =A0 =A0 =A0 =A0if [ $pass_count -lt 5 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS "Consolidation at package=
 level failed for \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> + =A0 =A0 =A0 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "Consolidati=
on at package level failed for \
> =A0unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=
=3D$sched_smt"
> - =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TFAIL "Consolidation at package=
 level passed for \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "Consolidati=
on at package level passed for \
> =A0unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=
=3D$sched_smt"
> - =A0 =A0 =A0 =A0 =A0 =A0fi ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> =A0 =A0 =A0 =A0 esac
> - =A0 =A0 =A0 fi
> =A0}
>
> =A0function analyze_wrt_wkld() {
> @@ -243,12 +228,11 @@ function analyze_wrt_wkld() {
> =A0 =A0 work_load=3D$2
> =A0 =A0 pass_count=3D$3
> =A0 =A0 =A0 =A0sched_smt=3D$4
> - =A0 =A0 =A0 stress=3D$5
>
> =A0 =A0 =A0 =A0check_supp_wkld $sched_mc $work_load; valid_workload=3D$?
> =A0 =A0 =A0 =A0if [ $hyper_threaded -eq $YES ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0analyze_wrt_workload_hyperthreaded $sched_=
mc $work_load $pass_count\
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$sched_smt $stress
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0$sched_smt
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$valid_workload" in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00)
> @@ -278,74 +262,56 @@ function analyze_result_hyperthreaded()
> =A0 =A0 work_load=3D$2
> =A0 =A0 pass_count=3D$3
> =A0 =A0 sched_smt=3D$4
> - =A0 =A0stress=3D$5
>
> + =A0 =A0 =A0 echo "sched_mc =3D$sched_mc =A0work-load=3D$work_load =A0pa=
ss_count=3D$pass_count =A0sched_smt=3D$sched_smt"
> =A0 =A0 =A0 =A0case "$sched_mc" in
> =A0 =A0 =A0 =A00)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if [ $sched_smt ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$sched_smt" in
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$stre=
ss" =3D "thread" ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if [ $pass_count -lt 1 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "Consolidation at core level failed for=
 sched_mc=3D\
> -$sched_mc & sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "Consolidation at core level passed for=
 sched_mc=3D\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$pass=
_count" -lt 5 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tst_resm TPASS "cpu consolidation failed for sched_mc=3D\
> =A0$sched_mc & sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if [ "$pass_count" -lt 1 ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "cpu consolidation failed for sched_mc=
=3D\
> -$sched_mc & sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 RC=3D1
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "cpu consolidation passed for sched_mc=
=3D\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 RC=3D1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TF=
AIL "cpu consolidation passed for sched_mc=3D\
> =A0$sched_mc & sched_smt=3D$sched_smt for workload=3D$work_load"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$stre=
ss" =3D "thread" ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt $stress
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 analyze_wrt_wkld $sched_mc $work_load $pass_count $sched_smt
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 analyze_wrt=
_wkld $sched_mc $work_load $pass_count $sched_smt
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0esac
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 1 ]; t=
hen
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; t=
hen
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm T=
PASS "cpu consolidation failed for sched_mc=3D\
> =A0$sched_mc for workload=3D$work_load"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RC=3D1
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm T=
FAIL "cpu consolidation passed for sched_mc=3D\
> -$sched_mc & sched_smt=3D$sched_smt for workload=3D$work_load"
> +$sched_mc for workload=3D$work_load"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0*)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ "$stress" =3D "thread" ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 analyze_wrt_wkld $sched_mc =
$work_load $pass_count $sched_smt $stress
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0analyze_wrt_wkld $sched_mc=
 $work_load $pass_count $sched_smt
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;;
> =A0 =A0 =A0 =A0esac
> =A0}
>
> -function analyze_consolidation_result() {
> +function analyze_package_consolidation_result() {
> =A0 =A0 =A0 =A0sched_mc=3D$1
> =A0 =A0 work_load=3D$2
> =A0 =A0 pass_count=3D$3
> =A0 =A0 =A0 =A0sched_smt=3D$4
> - =A0 =A0 =A0 stress=3D$5
>
> + =A0 =A0 =A0 echo "sched mc $sched_mc sched smt is $sched_smt workload $=
work_load pass count $pass_count"
> =A0 =A0 =A0 =A0if [ $hyper_threaded -eq $YES ]; then
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 analyze_result_hyperthreaded $sched_mc $wor=
k_load $pass_count $sched_smt $stress
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 analyze_result_hyperthreaded $sched_mc $wor=
k_load $pass_count $sched_smt
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case "$sched_mc" in
> =A0 =A0 =A0 =A0 =A0 =A00)
> - =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 1 ]; then
> + =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_resm TPASS "cpu consolidation =
failed for sched_mc=3D\
> =A0$sched_mc for workload=3D$work_load"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> @@ -360,6 +326,33 @@ $sched_mc for workload=3D$work_load"
> =A0 =A0 =A0 =A0fi
> =A0}
>
> +function analyze_core_consolidation_result() {
> + =A0 =A0 =A0 sched_smt=3D$1
> + =A0 =A0 =A0 work_load=3D$2
> + =A0 =A0 =A0 pass_count=3D$3
> +
> + =A0 =A0 =A0 case "$valid_workload" in
> + =A0 =A0 =A0 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "Consolidati=
on at core level failed for \
> +sched_mc=3D$sched_mc, sched_smt=3D$sched_smt for workload=3D$work_load"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "Consolidati=
on at core level passed for \
> +sched_mc=3D$sched_mc, sched_smt=3D$sched_smt & workload=3D$work_load"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> + =A0 =A0 =A0 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if [ $pass_count -lt 5 ]; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TPASS "Consolidati=
on at core level failed for \
> +unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=3D=
$sched_smt"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RC=3D1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm TFAIL "Consolidati=
on at core level passed for \
> +unsupported workload $work_load when sched_mc=3D$sched_mc & sched_smt=3D=
$sched_smt"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi ;;
> + =A0 =A0 =A0 esac
> +}
> +
> =A0function analyze_sched_domain_result(){
> =A0 =A0 =A0 =A0sched_mc=3D$1
> =A0 =A0 =A0 =A0result=3D$2

1. Check for files before cat'ing or at least redirect stderr to /dev/null.
2. Please quote any and all variables from files cat'ed out.
3. Please convert bash-ism's to bourne compatible routines, e.g.

function foo() {

}

... to...

foo() {

}

4. This form:

if [ $num_of_cpus -gt 1 ]; then
+                       return 0
+               else
+                       return 1
+               fi

Can be replaced by:

[ $num_of_cpus -gt 1 ]; return $?

etc.

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
