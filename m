Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1RzjeJ-0003GF-Sj
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 06:56:31 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RzjeG-0000Vp-2U
	for ltp-list@lists.sourceforge.net; Tue, 21 Feb 2012 06:56:31 +0000
Message-ID: <4F434018.8070804@cn.fujitsu.com>
Date: Tue, 21 Feb 2012 14:56:24 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F20EB81.4030109@cn.fujitsu.com> <4F433123.80702@cn.fujitsu.com>
	<4F43363D.5020806@casparzhang.com>
In-Reply-To: <4F43363D.5020806@casparzhang.com>
Content-Type: multipart/mixed; boundary="------------060006000406010700010509"
Subject: Re: [LTP] [PATCH v4 1/8] A library used to test memcg
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>


--------------060006000406010700010509
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8


Caspar Zhang said the following on 2012-2-21 14:14:
>>> This library includes a set of functions used to test memcg.
>>>
>>
>> Hi, Can you comment or commit the following patch?
>>
> 
> The patch looks good to me. Yet I'm not familiar with this part of
> codes, so I want to listen to others' opinion if possible.
> 
> Also, could you please provide a result log for your updated controller
> tests?
> 

Yeah.

[root@RHEL6U1GA-Intel64 ltp]# cat /opt/ltp/runtest/controllers
#DESCRIPTION:Resource Management testing
#cgroup         cgroup_regression_test.sh
#memcg_regression  memcg_regression_test.sh
memcg_function     memcg_function_test.sh
memcg_max_usage_in_bytes        memcg_max_usage_in_bytes_test.sh
memcg_move_charge_at_immigrate  memcg_move_charge_at_immigrate_test.sh
memcg_memsw_limit_in_bytes      memcg_memsw_limit_in_bytes_test.sh
memcg_stat      memcg_stat_test.sh
memcg_use_hierarchy memcg_use_hierarchy_test.sh
memcg_usage_in_bytes memcg_usage_in_bytes_test.sh
#memcg_stress      memcg_stress_test.sh
#memcg_control     PAGESIZE=$(mem_process -p);memcg_control_test.sh $PAGESIZE $PAGESIZE $((PAGESIZE * 2))
#cgroup_fj      run_cgroup_test_fj.sh
#controllers    test_controllers.sh
[root@RHEL6U1GA-Intel64 ltp]# cat /opt/ltp/results/LTP_RUN_ON-2012_Feb_21-13h_41m_03s.log
Test Start Time: Tue Feb 21 13:41:04 2012
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
memcg_function                 PASS       0
memcg_max_usage_in_bytes       PASS       0
memcg_move_charge_at_immigrate PASS       0
memcg_memsw_limit_in_bytes     PASS       0
memcg_stat                     PASS       0
memcg_use_hierarchy            PASS       0
memcg_usage_in_bytes           PASS       0

-----------------------------------------------
Total Tests: 7
Total Failures: 0
Kernel Version: 2.6.32-131.0.15.el6.x86_64
Machine Architecture: x86_64
Hostname: RHEL6U1GA-Intel64

The test stdout log can refer to the attached file memcg_test.log.

Thanks.

-- 
Best Regards,
Peng

--------------060006000406010700010509
Content-Type: text/plain;
 name="memcg_test.log"
Content-Disposition: attachment;
 filename="memcg_test.log"
Content-Transfer-Encoding: quoted-printable

INFO: creating /opt/ltp/results directory=0AIf some fields are empty or loo=
k unusual you may have an old version.=0ACompare to the current minimal req=
uirements in Documentation/Changes.=0A =0ARed Hat Enterprise Linux Server r=
elease 6.1 (Santiago)=0ARed Hat Enterprise Linux Server release 6.1 (Santia=
go)=0ALinux RHEL6U1GA-Intel64 2.6.32-131.0.15.el6.x86=5F64 #1 SMP Tue May 1=
0 15:42:40 EDT 2011 x86=5F64 x86=5F64 x86=5F64 GNU/Linux=0A =0AGnu C       =
           gcc (GCC) 4.4.5 20110214 (Red Hat 4.4.5-6)=0AGnu make           =
    3.81=0Autil-linux             ng 2.17.2)=0Amount                  ng 2.=
17.2 (with libblkid and selinux support)=0Amodutils               3.9=0Ae2f=
sprogs              1.41.12=0APPP                    2.4.5=0ALinux C Librar=
y        > libc.2.12=0ADynamic linker (ldd)   2.12=0AProcps                =
 3.2.8=0ANet-tools              1.60=0Aiproute2              iproute2-ss091=
226=0AKbd                    1.15=0ASh-utils               8.4=0AModules Lo=
aded         nfs lockd fscache nfs=5Facl auth=5Frpcgss veth lzo=5Fdecompres=
s lzo=5Fcompress ip6table=5Ffilter ip6=5Ftables ebtable=5Fnat ebtables ipt=
=5FMASQUERADE iptable=5Fnat nf=5Fnat nf=5Fconntrack=5Fipv4 nf=5Fdefrag=5Fip=
v4 xt=5Fstate nf=5Fconntrack ipt=5FREJECT xt=5FCHECKSUM iptable=5Fmangle ip=
table=5Ffilter ip=5Ftables bridge stp llc autofs4 sunrpc p4=5Fclockmod freq=
=5Ftable speedstep=5Flib ipv6 ext3 jbd dm=5Fmirror dm=5Fregion=5Fhash dm=5F=
log vhost=5Fnet macvtap macvlan tun uinput e1000 sg sky2 microcode rfkill w=
mi serio=5Fraw i2c=5Fi801 i2c=5Fcore iTCO=5Fwdt iTCO=5Fvendor=5Fsupport i63=
00esb shpchp e752x=5Fedac edac=5Fcore ext4 mbcache jbd2 sd=5Fmod crc=5Ft10d=
if mptspi mptscsih mptbase scsi=5Ftransport=5Fspi pata=5Facpi ata=5Fgeneric=
 ata=5Fpiix dm=5Fmod=0A=0Afree reports:=0A             total       used    =
   free     shared    buffers     cached=0AMem:       2055392    1981172   =
   74220          0      46772    1702056=0A-/+ buffers/cache:     232344  =
  1823048=0ASwap:      1048568          0    1048568=0A=0A/proc/cpuinfo=0Ap=
rocessor	: 0=0Avendor=5Fid	: GenuineIntel=0Acpu family	: 15=0Amodel		: 4=0A=
model name	: Intel(R) Xeon(TM) CPU 3.00GHz=0Astepping	: 1=0Acpu MHz		: 3000=
.000=0Acache size	: 1024 KB=0Aphysical id	: 0=0Asiblings	: 2=0Acore id		: 0=
=0Acpu cores	: 1=0Aapicid		: 0=0Ainitial apicid	: 0=0Afpu		: yes=0Afpu=5Fex=
ception	: yes=0Acpuid level	: 5=0Awp		: yes=0Aflags		: fpu vme de pse tsc m=
sr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr s=
se sse2 ss ht tm pbe syscall nx lm constant=5Ftsc pebs bts pni dtes64 monit=
or ds=5Fcpl cid cx16 xtpr=0Abogomips	: 5984.66=0Aclflush size	: 64=0Acache=
=5Falignment	: 128=0Aaddress sizes	: 36 bits physical, 48 bits virtual=0Apo=
wer management:=0A=0Aprocessor	: 1=0Avendor=5Fid	: GenuineIntel=0Acpu famil=
y	: 15=0Amodel		: 4=0Amodel name	: Intel(R) Xeon(TM) CPU 3.00GHz=0Astepping=
	: 1=0Acpu MHz		: 3000.000=0Acache size	: 1024 KB=0Aphysical id	: 3=0Asibli=
ngs	: 2=0Acore id		: 0=0Acpu cores	: 1=0Aapicid		: 6=0Ainitial apicid	: 6=
=0Afpu		: yes=0Afpu=5Fexception	: yes=0Acpuid level	: 5=0Awp		: yes=0Aflags=
		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clf=
lush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant=5Ftsc p=
ebs bts pni dtes64 monitor ds=5Fcpl cid cx16 xtpr=0Abogomips	: 5983.82=0Acl=
flush size	: 64=0Acache=5Falignment	: 128=0Aaddress sizes	: 36 bits physica=
l, 48 bits virtual=0Apower management:=0A=0Aprocessor	: 2=0Avendor=5Fid	: G=
enuineIntel=0Acpu family	: 15=0Amodel		: 4=0Amodel name	: Intel(R) Xeon(TM)=
 CPU 3.00GHz=0Astepping	: 1=0Acpu MHz		: 3000.000=0Acache size	: 1024 KB=0A=
physical id	: 0=0Asiblings	: 2=0Acore id		: 0=0Acpu cores	: 1=0Aapicid		: 1=
=0Ainitial apicid	: 1=0Afpu		: yes=0Afpu=5Fexception	: yes=0Acpuid level	: =
5=0Awp		: yes=0Aflags		: fpu vme de pse tsc msr pae mce cx8 apic mtrr pge m=
ca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall n=
x lm constant=5Ftsc pebs bts pni dtes64 monitor ds=5Fcpl cid cx16 xtpr=0Abo=
gomips	: 5983.87=0Aclflush size	: 64=0Acache=5Falignment	: 128=0Aaddress si=
zes	: 36 bits physical, 48 bits virtual=0Apower management:=0A=0Aprocessor	=
: 3=0Avendor=5Fid	: GenuineIntel=0Acpu family	: 15=0Amodel		: 4=0Amodel nam=
e	: Intel(R) Xeon(TM) CPU 3.00GHz=0Astepping	: 1=0Acpu MHz		: 3000.000=0Aca=
che size	: 1024 KB=0Aphysical id	: 3=0Asiblings	: 2=0Acore id		: 0=0Acpu co=
res	: 1=0Aapicid		: 7=0Ainitial apicid	: 7=0Afpu		: yes=0Afpu=5Fexception	:=
 yes=0Acpuid level	: 5=0Awp		: yes=0Aflags		: fpu vme de pse tsc msr pae mc=
e cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 s=
s ht tm pbe syscall nx lm constant=5Ftsc pebs bts pni dtes64 monitor ds=5Fc=
pl cid cx16 xtpr=0Abogomips	: 5983.81=0Aclflush size	: 64=0Acache=5Falignme=
nt	: 128=0Aaddress sizes	: 36 bits physical, 48 bits virtual=0Apower manage=
ment:=0A=0Aremove test cases which require the block device.=0AYou can spec=
ify it with option -b=0ACOMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 7439  =
   -n 7439  -p  -f /tmp/ltp-OvPMw6aqH2/alltests -l /opt/ltp/results/LTP=5FR=
UN=5FON-2012=5FFeb=5F21-13h=5F41m=5F03s.log  -C /opt/ltp/output/LTP=5FRUN=
=5FON-2012=5FFeb=5F21-13h=5F41m=5F03s.failed=0ALOG File: /opt/ltp/results/L=
TP=5FRUN=5FON-2012=5FFeb=5F21-13h=5F41m=5F03s.log=0AFAILED COMMAND File: /o=
pt/ltp/output/LTP=5FRUN=5FON-2012=5FFeb=5F21-13h=5F41m=5F03s.failed=0ARunni=
ng tests.......=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Ffunction stime=3D13298=
02864=0Acmdline=3D"	memcg=5Ffunction=5Ftest.sh"=0Acontacts=3D""=0Aanalysis=
=3Dexit=0A<<<test=5Foutput>>>=0ARunning /opt/ltp/testcases/bin/memcg=5Fproc=
ess --mmap-anon -s 4096=0AWarming up for test: 1, pid: 7562=0AProcess is st=
ill here after warm up: 7562=0Amemcg=5Ffunction=5Ftest    1  TPASS  :  rss=
=3D4096/4096=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-file -=
s 4096=0AWarming up for test: 2, pid: 7581=0AProcess is still here after wa=
rm up: 7581=0Amemcg=5Ffunction=5Ftest    2  TPASS  :  rss=3D0/0=0ARunning /=
opt/ltp/testcases/bin/memcg=5Fprocess --shm -k 3 -s 4096=0AWarming up for t=
est: 3, pid: 7600=0AProcess is still here after warm up: 7600=0Amemcg=5Ffun=
ction=5Ftest    3  TPASS  :  rss=3D0/0=0ARunning /opt/ltp/testcases/bin/mem=
cg=5Fprocess --mmap-anon --mmap-file --shm -s 4096=0AWarming up for test: 4=
, pid: 7619=0AProcess is still here after warm up: 7619=0Amemcg=5Ffunction=
=5Ftest    4  TPASS  :  rss=3D4096/4096=0ARunning /opt/ltp/testcases/bin/me=
mcg=5Fprocess --mmap-lock1 -s 4096=0AWarming up for test: 5, pid: 7638=0APr=
ocess is still here after warm up: 7638=0Amemcg=5Ffunction=5Ftest    5  TPA=
SS  :  rss=3D4096/4096=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --m=
map-anon -s 4096=0AWarming up for test: 6, pid: 7657=0AProcess is still her=
e after warm up: 7657=0Amemcg=5Ffunction=5Ftest    6  TPASS  :  rss=3D4096/=
4096=0Amemcg=5Ffunction=5Ftest    6  TPASS  :  rss=3D0/0=0ARunning /opt/ltp=
/testcases/bin/memcg=5Fprocess --mmap-file -s 4096=0AWarming up for test: 7=
, pid: 7681=0AProcess is still here after warm up: 7681=0Amemcg=5Ffunction=
=5Ftest    7  TPASS  :  rss=3D0/0=0Amemcg=5Ffunction=5Ftest    7  TPASS  : =
 rss=3D0/0=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --shm -k 8 -s 4=
096=0AWarming up for test: 8, pid: 7710=0AProcess is still here after warm =
up: 7710=0Amemcg=5Ffunction=5Ftest    8  TPASS  :  rss=3D0/0=0Amemcg=5Ffunc=
tion=5Ftest    8  TPASS  :  rss=3D0/0=0ARunning /opt/ltp/testcases/bin/memc=
g=5Fprocess --mmap-anon --mmap-file --shm -s 4096=0AWarming up for test: 9,=
 pid: 7733=0AProcess is still here after warm up: 7733=0Amemcg=5Ffunction=
=5Ftest    9  TPASS  :  rss=3D4096/4096=0Amemcg=5Ffunction=5Ftest    9  TPA=
SS  :  rss=3D0/0=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-lo=
ck1 -s 4096=0AWarming up for test: 10, pid: 7756=0AProcess is still here af=
ter warm up: 7756=0Amemcg=5Ffunction=5Ftest   10  TPASS  :  rss=3D4096/4096=
=0Amemcg=5Ffunction=5Ftest   10  TPASS  :  rss=3D0/0=0ARunning /opt/ltp/tes=
tcases/bin/memcg=5Fprocess --mmap-anon -s 8192=0A./memcg=5Flib.sh: line 174=
:  7780 Killed                  $TEST=5FPATH/memcg=5Fprocess $1 -s $2=0Amem=
cg=5Ffunction=5Ftest   11  TPASS  :  memory.failcnt=3D6=0ARunning /opt/ltp/=
testcases/bin/memcg=5Fprocess --mmap-file -s 8192=0A./memcg=5Flib.sh: line =
174:  7795 Killed                  $TEST=5FPATH/memcg=5Fprocess $1 -s $2=0A=
memcg=5Ffunction=5Ftest   12  TPASS  :  memory.failcnt=3D6=0ARunning /opt/l=
tp/testcases/bin/memcg=5Fprocess --shm -s 8192=0A./memcg=5Flib.sh: line 174=
:  7810 Killed                  $TEST=5FPATH/memcg=5Fprocess $1 -s $2=0Amem=
cg=5Ffunction=5Ftest   13  TPASS  :  memory.failcnt=3D6=0A./memcg=5Flib.sh:=
 line 209:  7825 Killed                  $TEST=5FPATH/memcg=5Fprocess $2 -s=
 $3=0Amemcg=5Ffunction=5Ftest   14  TPASS  :  process 7825 is killed=0A./me=
mcg=5Flib.sh: line 209:  7839 Killed                  $TEST=5FPATH/memcg=5F=
process $2 -s $3=0Amemcg=5Ffunction=5Ftest   15  TPASS  :  process 7839 is =
killed=0A./memcg=5Flib.sh: line 209:  7855 Killed                  $TEST=5F=
PATH/memcg=5Fprocess $2 -s $3=0Amemcg=5Ffunction=5Ftest   16  TPASS  :  pro=
cess 7855 is killed=0A./memcg=5Flib.sh: line 209:  7876 Killed             =
     $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Amemcg=5Ffunction=5Ftest   17  =
TPASS  :  process 7876 is killed=0A./memcg=5Flib.sh: line 209:  7896 Killed=
                  $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Amemcg=5Ffunction=
=5Ftest   18  TPASS  :  process 7896 is killed=0A./memcg=5Flib.sh: line 209=
:  7916 Killed                  $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Amem=
cg=5Ffunction=5Ftest   19  TPASS  :  process 7916 is killed=0A./memcg=5Flib=
.sh: line 209:  7930 Killed                  $TEST=5FPATH/memcg=5Fprocess $=
2 -s $3=0Amemcg=5Ffunction=5Ftest   20  TPASS  :  process 7930 is killed=0A=
./memcg=5Flib.sh: line 209:  7944 Killed                  $TEST=5FPATH/memc=
g=5Fprocess $2 -s $3=0Amemcg=5Ffunction=5Ftest   21  TPASS  :  process 7944=
 is killed=0Amemcg=5Ffunction=5Ftest   22  TPASS  :  input=3D4095, limit=5F=
in=5Fbytes=3D4096=0Amemcg=5Ffunction=5Ftest   23  TPASS  :  input=3D4097, l=
imit=5Fin=5Fbytes=3D8192=0Amemcg=5Ffunction=5Ftest   24  TPASS  :  input=3D=
1, limit=5Fin=5Fbytes=3D4096=0Amemcg=5Ffunction=5Ftest   25  TPASS  :  retu=
rn value is 0=0Amemcg=5Ffunction=5Ftest   26  TPASS  :  return value is 1=
=0Amemcg=5Ffunction=5Ftest   27  TPASS  :  return value is 1=0Amemcg=5Ffunc=
tion=5Ftest   28  TPASS  :  return value is 1=0Amemcg=5Ffunction=5Ftest   2=
9  TPASS  :  force memory succeeded=0Amemcg=5Ffunction=5Ftest   30  TPASS  =
:  force memory failed as expected=0Amemcg=5Ffunction=5Ftest   31  TPASS  :=
  return value is 0=0Amemcg=5Ffunction=5Ftest   32  TPASS  :  return value =
is 0=0Amemcg=5Ffunction=5Ftest   33  TPASS  :  return value is 0=0Amemcg=5F=
function=5Ftest   34  TPASS  :  return value is 0=0Amemcg=5Ffunction=5Ftest=
   35  TPASS  :  return value is 1=0ARunning /opt/ltp/testcases/bin/memcg=
=5Fprocess --mmap-anon -s 4096=0AWarming up for test: 36, pid: 8116=0AProce=
ss is still here after warm up: 8116=0Amemcg=5Ffunction=5Ftest   36  TPASS =
 :  rss=3D4096/4096=0Amemcg=5Ffunction=5Ftest   36  TPASS  :  rss=3D0/0=0AR=
unning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-anon -s 4096=0AWarming=
 up for test: 37, pid: 8141=0AProcess is still here after warm up: 8141=0Am=
emcg=5Ffunction=5Ftest   37  TPASS  :  rss=3D4096/4096=0Amemcg=5Ffunction=
=5Ftest   37  TPASS  :  rss=3D0/0=0ARunning /opt/ltp/testcases/bin/memcg=5F=
process --mmap-anon -s 4096=0AWarming up for test: 38, pid: 8166=0AProcess =
is still here after warm up: 8166=0Amemcg=5Ffunction=5Ftest   38  TPASS  : =
 rss=3D4096/4096=0Amemcg=5Ffunction=5Ftest   38  TPASS  :  rss=3D0/0=0A<<<e=
xecution=5Fstatus>>>=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D136 terminat=
ion=5Ftype=3Dexited termination=5Fid=3D0 corefile=3Dno=0Acutime=3D46 cstime=
=3D185=0A<<<test=5Fend>>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fmax=5Fusage=
=5Fin=5Fbytes stime=3D1329803000=0Acmdline=3D"memcg=5Fmax=5Fusage=5Fin=5Fby=
tes=5Ftest.sh"=0Acontacts=3D""=0Aanalysis=3Dexit=0A<<<test=5Foutput>>>=0ARu=
nning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-anon -s 4194304=0AWarmi=
ng up for test: 1, pid: 8200=0AProcess is still here after warm up: 8200=0A=
memcg=5Fmax=5Fusage=5Fin=5Fbytes=5Ftest    1  TPASS  :  memory.max=5Fusage=
=5Fin=5Fbytes=3D4194304/4194304=0ARunning /opt/ltp/testcases/bin/memcg=5Fpr=
ocess --mmap-anon -s 4194304=0AWarming up for test: 2, pid: 8218=0AProcess =
is still here after warm up: 8218=0Amemcg=5Fmax=5Fusage=5Fin=5Fbytes=5Ftest=
    2  TPASS  :  memory.memsw.max=5Fusage=5Fin=5Fbytes=3D4194304/4194304=0A=
Running /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-anon -s 4194304=0AWar=
ming up for test: 3, pid: 8235=0AProcess is still here after warm up: 8235=
=0Amemcg=5Fmax=5Fusage=5Fin=5Fbytes=5Ftest    3  TPASS  :  memory.max=5Fusa=
ge=5Fin=5Fbytes=3D4194304/4194304=0Amemcg=5Fmax=5Fusage=5Fin=5Fbytes=5Ftest=
    3  TPASS  :  memory.max=5Fusage=5Fin=5Fbytes=3D0/0=0ARunning /opt/ltp/t=
estcases/bin/memcg=5Fprocess --mmap-anon -s 4194304=0AWarming up for test: =
4, pid: 8254=0AProcess is still here after warm up: 8254=0Amemcg=5Fmax=5Fus=
age=5Fin=5Fbytes=5Ftest    4  TPASS  :  memory.memsw.max=5Fusage=5Fin=5Fbyt=
es=3D4194304/4194304=0Amemcg=5Fmax=5Fusage=5Fin=5Fbytes=5Ftest    4  TPASS =
 :  memory.memsw.max=5Fusage=5Fin=5Fbytes=3D0/0=0A<<<execution=5Fstatus>>>=
=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D24 termination=5Ftype=3Dexited t=
ermination=5Fid=3D0 corefile=3Dno=0Acutime=3D6 cstime=3D27=0A<<<test=5Fend>=
>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fmove=5Fcharge=5Fat=5Fimmigrate stim=
e=3D1329803024=0Acmdline=3D"memcg=5Fmove=5Fcharge=5Fat=5Fimmigrate=5Ftest.s=
h"=0Acontacts=3D""=0Aanalysis=3Dexit=0A<<<test=5Foutput>>>=0AWarming up for=
 test: 1, pid: 8290=0AProcess is still here after warm up: 8290=0Amemcg=5Fm=
ove=5Fcharge=5Fat=5Fimmigrate=5Ftest    1  TPASS  :  memory.usage=5Fin=5Fby=
tes=3D0/0=0Amemcg=5Fmove=5Fcharge=5Fat=5Fimmigrate=5Ftest    1  TPASS  :  m=
emory.usage=5Fin=5Fbytes=3D4096/4096=0AWarming up for test: 2, pid: 8312=0A=
Process is still here after warm up: 8312=0Amemcg=5Fmove=5Fcharge=5Fat=5Fim=
migrate=5Ftest    2  TPASS  :  memory.usage=5Fin=5Fbytes=3D4096/4096=0Amemc=
g=5Fmove=5Fcharge=5Fat=5Fimmigrate=5Ftest    2  TPASS  :  memory.usage=5Fin=
=5Fbytes=3D8192/8192=0AWarming up for test: 3, pid: 8334=0AProcess is still=
 here after warm up: 8334=0Amemcg=5Fmove=5Fcharge=5Fat=5Fimmigrate=5Ftest  =
  3  TPASS  :  memory.usage=5Fin=5Fbytes=3D8192/8192=0Amemcg=5Fmove=5Fcharg=
e=5Fat=5Fimmigrate=5Ftest    3  TPASS  :  memory.usage=5Fin=5Fbytes=3D4096/=
4096=0AWarming up for test: 4, pid: 8356=0AProcess is still here after warm=
 up: 8356=0Amemcg=5Fmove=5Fcharge=5Fat=5Fimmigrate=5Ftest    4  TPASS  :  m=
emory.usage=5Fin=5Fbytes=3D8192/8192=0Amemcg=5Fmove=5Fcharge=5Fat=5Fimmigra=
te=5Ftest    4  TPASS  :  memory.usage=5Fin=5Fbytes=3D0/0=0A<<<execution=5F=
status>>>=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D25 termination=5Ftype=
=3Dexited termination=5Fid=3D0 corefile=3Dno=0Acutime=3D7 cstime=3D21=0A<<<=
test=5Fend>>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fmemsw=5Flimit=5Fin=5Fbyt=
es stime=3D1329803049=0Acmdline=3D"memcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftes=
t.sh"=0Acontacts=3D""=0Aanalysis=3Dexit=0A<<<test=5Foutput>>>=0A./memcg=5Fl=
ib.sh: line 209:  8388 Killed                  $TEST=5FPATH/memcg=5Fprocess=
 $2 -s $3=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest    1  TPASS  :  proce=
ss 8388 is killed=0A./memcg=5Flib.sh: line 209:  8402 Killed               =
   $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fbyt=
es=5Ftest    2  TPASS  :  process 8402 is killed=0A./memcg=5Flib.sh: line 2=
09:  8416 Killed                  $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Am=
emcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest    3  TPASS  :  process 8416 is ki=
lled=0A./memcg=5Flib.sh: line 209:  8430 Killed                  $TEST=5FPA=
TH/memcg=5Fprocess $2 -s $3=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest    =
4  TPASS  :  process 8430 is killed=0A./memcg=5Flib.sh: line 209:  8444 Kil=
led                  $TEST=5FPATH/memcg=5Fprocess $2 -s $3=0Amemcg=5Fmemsw=
=5Flimit=5Fin=5Fbytes=5Ftest    5  TPASS  :  process 8444 is killed=0Amemcg=
=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest    6  TPASS  :  input=3D4095, limit=5F=
in=5Fbytes=3D4096=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest    7  TPASS  =
:  input=3D4097, limit=5Fin=5Fbytes=3D8192=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fb=
ytes=5Ftest    8  TPASS  :  input=3D1, limit=5Fin=5Fbytes=3D4096=0Amemcg=5F=
memsw=5Flimit=5Fin=5Fbytes=5Ftest    9  TPASS  :  return value is 0=0Amemcg=
=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest   10  TPASS  :  return value is 1=0Ame=
mcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest   11  TPASS  :  return value is 1=
=0Amemcg=5Fmemsw=5Flimit=5Fin=5Fbytes=5Ftest   12  TPASS  :  return value i=
s 1=0A<<<execution=5Fstatus>>>=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D23=
 termination=5Ftype=3Dexited termination=5Fid=3D0 corefile=3Dno=0Acutime=3D=
12 cstime=3D47=0A<<<test=5Fend>>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fstat=
 stime=3D1329803072=0Acmdline=3D"memcg=5Fstat=5Ftest.sh"=0Acontacts=3D""=0A=
analysis=3Dexit=0A<<<test=5Foutput>>>=0ARunning /opt/ltp/testcases/bin/memc=
g=5Fprocess --shm -k 3 -s 4096=0AWarming up for test: 1, pid: 8542=0AProces=
s is still here after warm up: 8542=0Amemcg=5Fstat=5Ftest    1  TPASS  :  c=
ache=3D4096/4096=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-fi=
le -s 4096=0AWarming up for test: 2, pid: 8562=0AProcess is still here afte=
r warm up: 8562=0Amemcg=5Fstat=5Ftest    2  TPASS  :  mapped=5Ffile=3D4096/=
4096=0ARunning /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-lock1 -s 4096=
=0AWarming up for test: 3, pid: 8587=0AProcess is still here after warm up:=
 8587=0Amemcg=5Fstat=5Ftest    3  TPASS  :  unevictable=3D4096/4096=0ARunni=
ng /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-lock2 -s 4096=0AWarming up=
 for test: 4, pid: 8606=0AProcess is still here after warm up: 8606=0Amemcg=
=5Fstat=5Ftest    4  TPASS  :  unevictable=3D4096/4096=0Amemcg=5Fstat=5Ftes=
t    5  TPASS  :  hierarchical=5Fmemory=5Flimit=3D4096/4096=0Amemcg=5Fstat=
=5Ftest    6  TPASS  :  hierarchical=5Fmemory=5Flimit=3D8192/8192=0Amemcg=
=5Fstat=5Ftest    7  TPASS  :  hierarchical=5Fmemsw=5Flimit=3D4096/4096=0Am=
emcg=5Fstat=5Ftest    8  TPASS  :  hierarchical=5Fmemsw=5Flimit=3D8192/8192=
=0A<<<execution=5Fstatus>>>=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D29 te=
rmination=5Ftype=3Dexited termination=5Fid=3D0 corefile=3Dno=0Acutime=3D9 c=
stime=3D33=0A<<<test=5Fend>>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fuse=5Fhi=
erarchy stime=3D1329803101=0Acmdline=3D"memcg=5Fuse=5Fhierarchy=5Ftest.sh"=
=0Acontacts=3D""=0Aanalysis=3Dexit=0A<<<test=5Foutput>>>=0A./memcg=5Flib.sh=
: line 209:  8696 Killed                  $TEST=5FPATH/memcg=5Fprocess $2 -=
s $3=0Amemcg=5Fuse=5Fhierarchy=5Ftest    1  TPASS  :  process 8696 is kille=
d=0Amemcg=5Fuse=5Fhierarchy=5Ftest    2  TPASS  :  return value is 1=0Amemc=
g=5Fuse=5Fhierarchy=5Ftest    3  TPASS  :  return value is 1=0A<<<execution=
=5Fstatus>>>=0Ainitiation=5Fstatus=3D"ok"=0Aduration=3D5 termination=5Ftype=
=3Dexited termination=5Fid=3D0 corefile=3Dno=0Acutime=3D4 cstime=3D13=0A<<<=
test=5Fend>>>=0A<<<test=5Fstart>>>=0Atag=3Dmemcg=5Fusage=5Fin=5Fbytes stime=
=3D1329803106=0Acmdline=3D"memcg=5Fusage=5Fin=5Fbytes=5Ftest.sh"=0Acontacts=
=3D""=0Aanalysis=3Dexit=0A<<<test=5Foutput>>>=0ARunning /opt/ltp/testcases/=
bin/memcg=5Fprocess --mmap-anon -s 4194304=0AWarming up for test: 1, pid: 8=
745=0AProcess is still here after warm up: 8745=0Amemcg=5Fusage=5Fin=5Fbyte=
s=5Ftest    1  TPASS  :  memory.usage=5Fin=5Fbytes=3D4194304/4194304=0ARunn=
ing /opt/ltp/testcases/bin/memcg=5Fprocess --mmap-anon -s 4194304=0AWarming=
 up for test: 2, pid: 8762=0AProcess is still here after warm up: 8762=0Ame=
mcg=5Fusage=5Fin=5Fbytes=5Ftest    2  TPASS  :  memory.memsw.usage=5Fin=5Fb=
ytes=3D4194304/4194304=0Aincrementing stop=0A<<<execution=5Fstatus>>>=0Aini=
tiation=5Fstatus=3D"ok"=0Aduration=3D12 termination=5Ftype=3Dexited termina=
tion=5Fid=3D0 corefile=3Dno=0Acutime=3D3 cstime=3D11=0A<<<test=5Fend>>>=0AI=
NFO: ltp-pan reported all tests PASS=0ALTP Version: 20120104-68-g2e2f72a=0A=
        =0A       #########################################################=
######"=0A        =0A            Done executing testcases."=0A            L=
TP Version:  20120104-68-g2e2f72a=0A       ################################=
###############################"=0A       =0A=

--------------060006000406010700010509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------060006000406010700010509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060006000406010700010509--


