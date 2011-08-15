Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lgliang@taco.beaverton.ibm.com>) id 1Qt2uw-0001gy-SN
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:33:46 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qt2uv-0005E0-EE
	for ltp-list@lists.sourceforge.net; Mon, 15 Aug 2011 19:33:46 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p7FIUnTg029704
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 14:30:49 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p7FIv9Fc255672
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 14:57:09 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p7FIv9tH006345
	for <ltp-list@lists.sourceforge.net>; Mon, 15 Aug 2011 14:57:09 -0400
From: Lucy Liang <lgliang@linux.vnet.ibm.com>
Date: Mon, 15 Aug 2011 11:56:32 -0700
Message-Id: <1313434593-7942-6-git-send-email-lgliang@linux.vnet.ibm.com>
In-Reply-To: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
References: <1313434593-7942-1-git-send-email-lgliang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.4.1"
Subject: [LTP] [PATCH 6/7 ver2 w/attachment] Modified pounder install and
	run scripts
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
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.4.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Made changes to two files here, the Install script that builds
pounder, and the pounder script that runs it. Updated the Install
script to have it now list the available test schedulers for user
selectrion prior to starting the build process. Install also now
includes the functionality for allowing users to skip subtests
that failed to build rather than just exiting out of the entire
build process due to a single subtest failure.

The updated pounder script now includes the -m, -c, -l, -e, -i,
and -h options (README has more info). The -c, -e, -i options
handle creation and modification of test schedulers. The -m
option sets an upper bound on output of repeatedly run subtests.
The -l option lists subtests packaged with the test scheduler
and the -h option gives description of pounder usage. Also moved
all the provided test schedulers into newly created schedulers/
directory.

Signed-off-by: Lucy Liang <lgliang@linux.vnet.ibm.com>
---
 tools/pounder21/Install                         |   63 ++++++--
 tools/pounder21/default-tests.tar.gz            |  Bin 1441 -> 0 bytes
 tools/pounder21/fast-tests.tar.gz               |  Bin 1292 -> 0 bytes
 tools/pounder21/pounder                         |  174 ++++++++++++++++++-----
 tools/pounder21/schedulers/default-tests.tar.gz |  Bin 0 -> 1663 bytes
 tools/pounder21/schedulers/fast-tests.tar.gz    |  Bin 0 -> 1494 bytes
 tools/pounder21/schedulers/test-tests.tar.gz    |  Bin 0 -> 1057 bytes
 tools/pounder21/test-tests.tar.gz               |  Bin 1006 -> 0 bytes
 tools/pounder21/testall-tests.tar.gz            |  Bin 314 -> 0 bytes
 9 files changed, 186 insertions(+), 51 deletions(-)
 delete mode 100644 tools/pounder21/default-tests.tar.gz
 delete mode 100644 tools/pounder21/fast-tests.tar.gz
 create mode 100644 tools/pounder21/schedulers/default-tests.tar.gz
 create mode 100644 tools/pounder21/schedulers/fast-tests.tar.gz
 create mode 100644 tools/pounder21/schedulers/test-tests.tar.gz
 delete mode 100644 tools/pounder21/test-tests.tar.gz
 delete mode 100644 tools/pounder21/testall-tests.tar.gz


--------------1.7.4.1
Content-Type: text/x-patch;
	name="0006-Modified-pounder-install-and-run-scripts.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0006-Modified-pounder-install-and-run-scripts.patch"

diff --git a/tools/pounder21/Install b/tools/pounder21/Install
index fe8db05..5bbfe2f 100755
--- a/tools/pounder21/Install
+++ b/tools/pounder21/Install
@@ -24,7 +24,7 @@ source libpounder.sh
 export USE_CACHE=1
 
 # do we actually _have_ a cache server?
-if [ -z "$POUNDER_CACHE" ]; then
+if [ -z "$POUNDER_CACHE" -o "$POUNDER_CACHE" == "0" ]; then
 	export USE_CACHE=0
 fi
 
@@ -73,7 +73,12 @@ UNPACKED=0
 
 while [ "$UNPACKED" -lt 1 ]; do
 	# Unpack default test configuration?
-	echo -en "Which test scheduler setup do you want to unpack? [$DEFAULT_SCHEDPACK or \"NONE\"] "
+	SCHEDULERS=`ls $POUNDER_HOME/schedulers | awk -F"-tests.tar.gz" '{print $1}'`
+	echo "WHICH TEST SCHEDULER SETUP DO YOU WANT TO UNPACK?"
+	echo "[Choose from:"
+	echo "$SCHEDULERS"
+	echo "[Or simply press ENTER for the default scheduler]"
+	echo -n "Scheduler selection: "
 	read f
 	if [ -z "$f" ]; then
 		SCHEDPACK="$DEFAULT_SCHEDPACK"
@@ -81,22 +86,26 @@ while [ "$UNPACKED" -lt 1 ]; do
 		SCHEDPACK="$f"
 	fi
 
-	if [ "$f" != "NONE" ]; then
-		rm -rf tests/*
+	rm -rf tests/*
 
-		tar -xzvf "$SCHEDPACK-tests.tar.gz"
+	tar -xzvf "$POUNDER_HOME/schedulers/$SCHEDPACK-tests.tar.gz"
 
-		if [ "$?" -ne 0 ]; then
-			echo "Unable to untar $SCHEDPACK-tests.tar.gz; please try again."
-		else
-			echo "Untarred $SCHEDPACK-tests.tar.gz successfully."
-			UNPACKED=1
-		fi
+	if [ "$?" -ne 0 ]; then
+		echo "Unable to untar $SCHEDPACK-tests.tar.gz; please try again."
 	else
+		echo "Untarred $SCHEDPACK-tests.tar.gz successfully."
 		UNPACKED=1
 	fi
 done
 
+echo -en "Would you like to automate skipping of failed subtests? (subtests that failed to build will automatically be removed from test scheduler) [y/n]? "
+read f
+if [ "$f" == "y" -o "$f" == "Y" ]; then
+	AUTO_SKIP=1
+else
+	AUTO_SKIP=0
+fi
+
 # start builds...
 for i in $BUILDS
 do
@@ -104,10 +113,34 @@ do
 		continue
 	fi
 	if [ -x "build_scripts/$i" ]; then
-		echo "Building $i..."
-		"build_scripts/$i" $*
-		if [ "$?" -ne 0 ]; then
-			exit 1
+		FOUND=`find $POUNDER_HOME/tests -name *$i`
+		if [ -n "$FOUND" ]; then	
+			"build_scripts/$i" $*
+			BUILD_ERR=$?
+			if [ "$BUILD_ERR" -ne 0 ]; then
+				if [ $AUTO_SKIP -eq 0 ]; then
+					echo -en "$i build failed with Error $BUILD_ERR. If this is a subtest, would you like to skip it [y/n]? "
+					read f
+					if [ "$f" == "y" -o "$f" == "Y" ]; then
+                        			rm `find $POUNDER_HOME/tests -name *$i` > /dev/null 2>&1
+						if [ "$?" -ne 0 ]; then
+							echo "Failed to remove $i from test scheduler. $i is either not a subtest included in $SCHEDPACK-tests.tar.gz or is incorrectly defined in $POUNDER_HOME/tests (See SCHEDULER for naming rules if this is the case)."
+							echo -en "Skip anyway? [y/n] "
+							read f
+							if [ "$?" == "y" -o "$f" == "Y" ]; then
+								exit 0
+							elif [ "$f" == "n" -o "$f" == "N" -o -z "$f" ]; then
+								exit 1
+							fi
+						fi
+                			elif [ "$f" == "n" -o "$f" == "N" -o -z "$f" ]; then
+						echo "Exiting install ..."
+						exit 1
+					fi
+				else
+					rm `find ./tests -name *$i` > /dev/null 2>&1
+				fi
+			fi
 		fi
 	fi
 done
diff --git a/tools/pounder21/default-tests.tar.gz b/tools/pounder21/default-tests.tar.gz
deleted file mode 100644
index 7f1bb20b7fafc15682ed07273211243e2a6b4442..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1441
zcmZXRdo+}J9EZnci>8xtv}?AO(I8t1lah|M$t~@gQY1<YqoXSk($wk|Vyek(sU{(n
zgGiz_a_glm2Q}7xqK4x(BiD>^d3k@|_5XhUeExf$596j5<-_<2XNtyH`o8dP8(KnS
z$4h^+l=^k8^q#`~mA2NEe-9tOW1V=%C}o@T7L#pB5Uu83#A&lI)rookeV4xJ;o9BP
z;}#dLnzrQ@pRo+`v)9tCFXcPC3%NQUt#}+J=dF`<JWI^GABwlGk(T&&nAD#oXM;UM
zGEkJq1b(2*4=kx|$IH8t4brmNSq@uX*tHTKH7o@qwg`FcE%-)eAM81n)I35mh`{wp
zM0h`NcrV!JcU;f8I7s00gS-^6eq(;+{vl;S{kMU1;!%|LC9(f5Y@svfCFU2sn1;}>
zNTkm%t#7RGICao7a?6z_x_ei_!-|fX2&<=jNR=TQz(HK)AtZsy9E#-H8D!2zZ7}O&
zyTns}=cH9RERQ|X(qvlsX-YC2QCo2yN>p5@r#S5~re#jDM9$a>BC$#WioCpu7Ur4a
zjbm%FjtN;Q5S9!9xxq1t?Lu_O0qJYH&G$$JMmoZuy5aMs==63~dLwK9b65s-dmj>R
zq3VdC&PJFOb8<mZq{P;^qC_L0Ui}e@6jSMcbnbf>Hv7a)j?L{tdZ(x5cZ~(GZc-0K
zdo*2lf03$ifhn?HLWR>@^M}zXU;X6Qk{dApjmVfZ+_PFw$Qo|Kb~Kx+)c|Fu0F?8o
z1Il+C8_(p363<tX@h-m4ubyV!cU<F*65vnid`42~U|Cnzm~VN*jraBR)_Ded2$QA(
z)gb^ZwXRIzMY{H@=$12xab#S{OP4*%J`_>`t0AY3!~$lZly(4qs1^ZxD{~S(D4GRt
za}^_ju++RjikQtAj^IKYRb|M}+$-p~C6RqxSCGt-)B}s9!mI976H6IJV5yXbK;I5E
z?(M^`tnI@nwZy`FmDwzI-F6(@TV_E|3fk{aLX>ngtFU?DQsD@GlEAcUfF>PbCplpk
zk@3ozdC{UQH%MIUo7vUTOqY+s!#FOfp-uJ#OnSg?Tba)guT}=S&c)$UqS<;FMiubD
zJsAQUs==|h4sPjQ?ZGuiRXqb(aLU)WLbX<8`3CgD)daiWPJqJ!NUZjPI)5jc2CuFF
zGKb-s9E<bsgrYA%X@dA_34DLGvGG_XHW4ZuCKv__c)|jv8H*;2IQh^NLb3DKHKE)N
zd<o5I@LtKbFC1Z)d6aM6bmR13h_JPf-QGf7pF0e4=>SFpvOfovZ)XbNcAy-ZcY+Ry
z+ZQUqb*yaYghky08C(v9o4<^M6Aj{eH=|VCaav^94f;pRCf2r3W|gxfxlnY(ECRXo
zq8y`(N~jhXsXHb4!guuTzNcp~zdQH*V4wD1r$AhX7(5AFi&3#x8cqOzNpKnO9~s=t
z2E9i>jWvLSrD5$e{H6%fCFwgO1-S)r)R!JwtighvXj5FxVtD;DeC^^1`8+!)e->LQ
z$L%NE;B$K~SgPAWxzGgS<k$!Q3~&ku>Q2y)XAqVVio<yvvGZY>tzrLJ@{>j34p^8B
zsK}ptV5~Sd?J_s{`To7jR9h~_r1OtrIpLb*Eku9AFWr1se2(I577cQHY-~=;V?_`A
zyvzqP&`$G;kuTuL*kG||m72tCIpISjSI7o^Jxj|-Wjw)nZI3mWI7b7+F%-OLk`XZE
zPDK{#J)7oQ!3;LAxJ;nzXMZ4-Y*7s+Prf{ez!+S{e7pa2ectkc-sBA%GDU+Bl!TY1
z8!OlfEIL)3+R#XE`ZpsC36M{FR%c0W>-AVf#8tMaFma^B?aJ~;PuO)+EZ81yo;PL_
Zl~c2+lR^34=1S+5N2v@WDUT_X{{Sh`FIfNp

diff --git a/tools/pounder21/fast-tests.tar.gz b/tools/pounder21/fast-tests.tar.gz
deleted file mode 100644
index 37b58a22b1c10a74ef32cd2d9fd48dc62106f920..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1292
zcmZvY`A?Gv9EV{d7Q}%Zsaj`&fgIW7iWVdI&I=+#P-=0;LDd3{AQCP+L3k01pe?q-
z+#p2CDI%%Pi)|_vR46DEok~Hj4lESQ-4^WIzVCPa1NQm(`6N#sDvxBgr8|3%*@~GP
z2T}$D?Jngk-JL(VT6?g{rTs4U@OQ`l*JsGQ*`vbb&2K|~dsve12D$qOZY8^l$MWLV
zf6CcnJ?(s0E3;vDRtKwcRXz#3T)1&zq-^)F%Gl*@&n~WOR6<D)slKFWU^ll#{0#>`
zn89m5t(nWAGf`N+IfB;P)DldusVm8p&aW#Q5LQ&`{y;x0fVJigV%dP9?&U2bk7A|k
zbkU#BVHByy;WQbWw-CE%sM+{*MCSDd_CmZXw%QVBDO8dByfFtA^&%bju{uVZVZ}NP
zKav$jBvD!XEI3Xy?B0Mk*6fX&Skr`*W;8qRv=ogMt3mBUZo2>MCnvn;<WB12nwY0@
zTjd|lbL7L_qqt5fLVOUo0fbV}OODTB^eL+}w@-a+pUUnNF6Itj7vJ-c7EO#Z&o2)e
z+3;s;yAFLeFyxqQP^I(t!{jPxc-ieRv9huaSauz-9AY7f+(ZNR<xl9(&cM6i0F4`8
ziDk5ybIQ5u$VpUt%-CD@f$1AzXW};#R6dFR!^gjLl5jVoLYVi3Y90#8`%jv9hKl=(
zQTn;EE5I#YV3I1mw#`COxHAZzA2N!14PolDZAU{$W4giC9tiIi(|WeeQ4N`g7_l8?
zGI;3%wL=|fdI3nC!wF8}-cIv(?J@8=niK!1D<$(t5;6iCfnBIWPsyRc@fOsW)CI+)
z5t08aMvbf^#_e@Xn;}e8SA$?kjY0-BL#p#FQ{hVqwA2=UY6KA(FbE#SD~}U`U1fTB
zUnDfI<57U&x-fbNT!=zx4@6DDxHTqijRCst#o6X_NXFy2;NsK>T(oeHIHCgH9@DYE
z$k))ouYlLL`?H2HO1T!zokw3y6V!$!qpcAMI$<2$u+~UyRZO5=T2x^SbsWNc$~CA8
z`1w2F9fK~fC+6G6*S*st+o!?m2_ZdTo~K7F9W=nBnJq_i-JDa0^hmi5(V`)3#UN_V
zN@8lZcVyt44B|&qSno?;s26>8qa#Ijc&Ste_19+q4da|trts4jk;F+WZ_j<eam?3)
ztjNyXUOEhG$KQ%G>C5qmDr=^8MchaDZ~{CYs3lRR6nk1VXlMx6SLl5P4|QmSH$YxR
zBTBJX@@AmjR7<Aq;PNoA!>R$XJ~1ZobLAS3T%Z8rZVzuwC<lDX^;8k8FQDTug613b
zqPVj-t+pi1tGyp;*L{|F2Bi|Bv3VG5>w#qBoO-N}ZL7#2Qsk(=%;_3;Py_jKoltA{
z*=W)|Xi;~y0^BuvG!Q5&X~YBZ$izOz)+Ce_lmdc#-Nrb7Nh;WifLwUofbRJAxrH$B
z4rmhRDMt3B82<5tac&g^SYME#Hs1#UL$L(6GP5}!rr`WlzZqB*g5NVWywKnEw7`hM
z8*5!G-2}$~*Y=_tB(O%u{B8+zNJ~$7`ozk=V?c+7oHd|Sr1H}Bq~K4q<-g^W0%D>q
z);@953q^~DC0(s0|B6(@F9Jq-P7Fr>3KI~KJpp}>W$FZmlTIx6lgW|N@ZfqhFPlq5
mgE9?H<4s_XH<m0Ku<RBo?G9r0zsr+%!R*oZ&&{gL%>Dyq*x#i9

diff --git a/tools/pounder21/pounder b/tools/pounder21/pounder
index 095e0c0..9382d87 100755
--- a/tools/pounder21/pounder
+++ b/tools/pounder21/pounder
@@ -19,29 +19,6 @@
 # Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
 # 02111-1307, USA.
 
-# By default, pounder runs forever.  Howver, the -k option can be used to stop
-# all the tests.  Our process ID (which is the process-group ID of all our
-# children) is saved in a file called pounder_pgrp in the POUNDER_HOME
-# directory.  A negative sign is prepended to the PID so that a simple
-# "kill -TERM `cat $POUNDER_HOME/pounder_pgrp`" will stop all the tests.
-#
-# Howver, if a test starts an xterm, then all its sub-processes will run under
-# a new process-group, which requires that the test regester its own PID (with
-# a negative sign prepended) to the pounder_pgrp file.  See the testtime script
-# for an example of this.
-#
-# To schedule pounder to run for a limited length of time, use the -d option
-# to set a duration in hours for the run.  A process will be spawned that will
-# sleep the allotted time and then kill the process group(s) in pounder_pgrp.
-# If you decide to stop the tests, pounder -k will kill the sleeping process as
-# well.
-#
-# It should also be noted that in order to clean up completly, some tests may
-# need to trap interrupts and do some cleanup.  See the testnet script for an
-# example of this.
-#
-# Author: Darrick Wong <djwong@us.ibm.com> and John Stultz <johnstul@us.ibm.com>
-
 source libpounder.sh
 
 # This function kills off pounder and related subprocesses.
@@ -56,34 +33,158 @@ function dokill() {
 
 function help() {
 	cat << ENDL
-Usage: $0 [-l logdir] [-x] [-d duration] [-n ipaddr] [-f] [-u|-r|-k] [-s]
-
--x	Enable X stress tests.
--d	Run pounder for duration seconds.
--n	Use ipaddr for NFS tests.
--f	Remove pounder pid file before running.
--u	Unmount NFS log storage.
--r	Remount NFS log storage.
--l	Use logdir as the log directory. (You probably want -s too.)
--s	Store logs locally.
--k	Kill pounder.
+Usage: ./pounder [-g logdir] [-x] [-d duration] [-n ipaddr] [-m max_failures] [-f] [-h|-u|-r|-k|-l|-e subtests|-i subtests|-c scheduler] [-s]
+
+-h      	Brings up this menu
+-c scheduler	Creates a new test scheduler called scheduler-tests.tar.gz in the pounder/schedulers folder.
+		All subtests to be packaged with this scheduler must first be placed in the pounder/tests folder. 
+-x      	Enable X stress tests.
+-d duration	Run pounder for duration seconds.
+-n ipaddr	Use ipaddr for NFS tests.
+-f		Remove pounder pid file before running.
+-u      	Unmount NFS log storage.
+-r      	Remount NFS log storage.
+-g logdir      	Use logdir as the log directory. (You probably want -s too.)
+-s      	Store logs locally.
+-l      	List (both included and excluded) subtests that came with the test scheduler
+-e subtests     Exclude subtests from next pounder run
+-i subtests     Include previously excluded subtests in the next pounder run
+-k      	Kill pounder.
+
+run "./pounder" to run all subtests
+run "./pounder subtest" to run just one particular subtest
+        (example: ./pounder tests/T90ramp/D02build_kernel)
 ENDL
 }
 
+function exclude() {
+	echo "excluding from tests $@..."
+
+	POUNDER_TESTS=$POUNDER_HOME/tests
+	SUBTESTS_INC=`find $POUNDER_TESTS -name excluded -prune -o -type f -print -o -type l -print`
+
+	for i in $@
+	do
+		BASENAME=`basename "$i"`
+
+		ORIG_DIR=`pwd`
+		cd `dirname $i`
+		FULL_PATH=`pwd`/"$BASENAME"
+		cd $ORIG_DIR 
+
+		FOUND=`echo "$SUBTESTS_INC" | grep -x "$FULL_PATH"`
+
+		if [ -n "$FOUND" -a -x "$i" ]; then
+
+			ALREADY_EXCLUDED=`grep -w "$BASENAME" $POUNDER_TESTS/excluded/testlist | cut -d " " -f1`
+			if [ $ALREADY_EXCLUDED ]; then
+				echo $ALREADY_EXCLUDED
+				echo "$BASENAME has already been excluded from the test scheduler. Make sure the test names in the test scheduler are unique."
+				exit 1
+			fi
+
+			echo "$BASENAME" "$FULL_PATH" >> "$POUNDER_TESTS"/excluded/testlist
+			mv "$i" "$POUNDER_TESTS"/excluded/"$BASENAME"
+
+			if [ $? -eq 0 ]; then
+				echo "Successfully removed $i from test scheduler."
+			else
+				echo "Removal of $i from tests UNSUCCESSFUL."
+			fi
+		else
+			echo "$i is not a subtest included in the current scheduler. Use ./pounder -l for list of valid, excludable subtests."
+		fi
+	done
+}
+
+function include() {
+	echo "including in tests $@..."
+
+        POUNDER_EXCLUDED=$POUNDER_HOME/tests/excluded
+
+        for i in $@
+        do
+		ORIG_FILE=`grep -w "$i" $POUNDER_EXCLUDED/testlist | cut -d " " -f2`
+
+		if [ -n "$ORIG_FILE" ]; then
+			mv $POUNDER_EXCLUDED/$i $ORIG_FILE
+			if [ $? -eq 0 ]; then
+				sed "/$i /d" $POUNDER_EXCLUDED/testlist > $POUNDER_EXCLUDED/tempfile
+				mv $POUNDER_EXCLUDED/tempfile $POUNDER_EXCLUDED/testlist
+				echo "Successfully added $i back to test scheduler."
+			else
+				echo "Addition of $i to tests UNSUCCESSFUL."
+			fi
+		else
+			echo "$i is not an excluded subtest. It may already be included in the current scheduler. Use ./pounder -l for list of valid, includable subtests."
+		fi
+        done
+}
+
+function list_tests() {
+
+	if [ ! -d $POUNDER_HOME/tests ]; then
+		echo "Error: No test schedule found. Did you run make install?"
+		exit 1
+	fi
+
+	echo "Included subtests:"
+	INCLUDED_TESTS=`find $POUNDER_HOME/tests -name excluded -prune -o -type f -print -o -type l -print`
+	if [ -z "$INCLUDED_TESTS" ]; then
+		echo "[NONE]"
+	else
+		echo "$INCLUDED_TESTS"
+	fi
+	echo
+
+	echo "Excluded subtests:"
+
+	if [ ! -d $POUNDER_HOME/tests/excluded ]; then
+		echo "Error: $POUNDER_HOME/tests/excluded folder does not exist. Make sure your test scheduler was created or unpackaged correctly. Did you run make install?"
+		exit 1
+	fi
+
+	EXCLUDED_TESTS=`grep -v "#" $POUNDER_HOME/tests/excluded/testlist`
+	if [ -z "$EXCLUDED_TESTS" ]; then
+		echo "[NONE]"
+	else
+		echo "$EXCLUDED_TESTS" | cut -d " " -f1
+	fi
+
+}
+
+function create_scheduler() {
+	TESTS_EXCLUDED=$POUNDER_HOME/tests/excluded
+	REPO_EXCLUDED=$POUNDER_HOME/test_repo/excluded
+
+	if [ ! -d $TESTS_EXCLUDED ]; then
+		cp -r $REPO_EXCLUDED $TESTS_EXCLUDED
+	elif [ ! -e $TESTS_EXCLUDED/testlist ]; then
+		cp $REPO_EXCLUDED/testlist $TESTS_EXCLUDED/testlist
+	fi
+
+	tar -czf $POUNDER_HOME/schedulers/$@-tests.tar.gz tests
+}
 # process options: -x to run in xterms, -k to kill tests, -d to set duration,
 # -f to remove bogus pounder.pid files.
-while getopts d:kn:l:xurs? o
+while getopts d:kn:g:xure:i:m:c:shl? o
 do
 	case "$o" in
 	   d) export DURATION="$OPTARG";;
 	   k) dokill; exit;;
 	   n) export NFS_SERVER="$OPTARG";;
-	   l) export POUNDER_LOGDIR="$OPTARG";;
+	   g) export POUNDER_LOGDIR="$OPTARG";;
 	   x) export DO_X_TESTS=1;;
 	   f) rm -rf "$POUNDER_PIDFILE";;
 	   u) umount $POUNDER_HOME/log 2> /dev/null; exit 0;;
 	   s) export NFS_LOGGING=0;;
 	   r) ./nfs_logging; exit;;
+	   e) exclude $OPTARG; exit;;
+	   i) include $OPTARG; exit;;
+	   l) list_tests; exit;;
+	   m) export MAX_FAILURES="$OPTARG";;
+	   c) create_scheduler $OPTARG; exit;;
+	   h) help $0; exit;;
 	   '?') help $0; exit 1;;
 	esac
 done
@@ -157,6 +258,7 @@ fi
 # Dump environment variables...
 export > "$POUNDER_LOGDIR/environment"
 
+echo "Starting $POUNDER_VERSION"
 echo "STARTING TESTS." > /dev/tty
 echo "To kill all tests, run 'pounder -k' or press ^C."> /dev/tty
 
diff --git a/tools/pounder21/schedulers/default-tests.tar.gz b/tools/pounder21/schedulers/default-tests.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ac20bc9683618886e385a17e9fb2fe19b830e2fd
GIT binary patch
literal 1663
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
Je}({{0038brBMI?

literal 0
HcmV?d00001

diff --git a/tools/pounder21/schedulers/fast-tests.tar.gz b/tools/pounder21/schedulers/fast-tests.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..5984a5ce372367e33902adcc831d830ba7910dac
GIT binary patch
literal 1494
zcmZvZdpMH|9LML<X}N?J2dR04mQLj8Ns%q5#K~oqsE(Lio-R+Q$8BkP3s2O_s7|^u
zE#*=OT|~1YO)1QzqNtE%W@7Kgw)g#=&iVU%|N8v<`FzQ2BEhHKBZ#0UEA&qoT4O3q
zSC&TR&r#kx*OE=Cr1S0B;l+*1`xg4pGY*OJP5DkQ1C{+Q%RL_i+KbY>YmL?mHrfbH
z46e?08u^xVv#aFJj-k&i#W{&+&dtfmBkfsvd54!oE^wVy<xK9+sQ=W`cW**n;?vf;
zmD+8h{MDpAs_;xt?$Yso#s{^7CfFwM9;;bbs7#PHq`DUE+ppY7XFqW}=6LaBi!HMk
z|BX0TGuLSPMBBT0h7_*tAqA!A%X1lWD*pGASCjjD3OAqz=<b0VArVA-vc~$;JW(-q
zcT!o^?R^qzdx6!#vE;wcSR_kZKX0HMn3I-dcmJSt`*BWQ!p>@5O8A>D#+9<?f+@E;
zwvf(c3tiUArPDIuNcQkkX;2C6j-1JwTXBASamki#7Zg?v=3Y)?{bBj9RQq`5b>-TT
zDeLsdP2SvU7h3wvqE9TXVy=4f`@1_I6hLjqYeiuE;zN2w<-rxvMrj<LNK2kNL9*C_
zW$$W5Jgyn*ET6a(H_+B{F_crMc`rHn2VSsDxqx)kTHVoMNs9sss~K-`b^0*+wz51^
zPqP9eeRPbCKConxj|yrL(+Vvo#EO6l^ybSDH*R}OVVgaJm>6xOJpK|t8$b*lp`F`B
z8AY;A8F^Mg(8W5gv&GTm8o!1^9x{WF@i}Lsj2y%V4wr$y&B|+Ng*jZdi4K4mPYC|O
za5T7uSTE=j7%CN<+v27`Yene#VXx){voB(IK{(8gOpU2#hS1SFhP#=gAp`9CGU+di
zn^Lxx#TD-NV2Q6WY%eq0Z{Tk^Gt`%FR7k{Y*fB;9eyd}!kvfcQ-T*;NJ0SVtrI|%=
zwCD`;%EM$U7wNY<`L3I%1uU6BOD@A{LuNe?bngO~6cS$%5Rrn;%Z|7o`w^{_1U%3a
zqMa!i8KpK`rlw<~n`&-C`Z8TqbG8cUa}04BN>M!sbM)C8b2fU4W?0^h_}Tq*8J9rU
zX<OYHb}uXo@TyvLGuj5hT%J|{U3P!z{B=h#sdBXGJvRdjFYbiF0^Sb9ZQTo33|Vs*
zZm!PK%Jn^G5$UG98NM$Y-WO=;OLM@vYZ@6ojb)=qBqEh4O;|NF9Zll~Ieb1C%QBZR
zG2c{_9E>r(&*_5Xj6yZt!>s3cwXPQ)P5&zB1HB)E)HF;UhzXzK&Rr;deGSd{*}p_i
zi$WyO;QdbEuFRg1>+_+rC!@07uP@9@Rk^CxaDNgmRP};*FQnR+X03w66Sq*v4$@Eb
zP7rBmcNfN9U+BYM?f#-3PyNC5al(V0#RSQqPHz>&T_;|YuWP_FdG2A_z+5TBPXNz=
z@LwK=hZzMzir+y}O$U2*6DiK&^<CU69;3B7ft$hXpmB;qAm3z4WNq$*C!PLgF4Btj
z#)uvMBu|16CCjF04i&KRv$}fGxP*~vm!s3flhSMg3LehB+9OWh12Lt@nsMM*D&TtL
zHpnEMoWeE>aCg;++T<=A&R7C(QK;H7VKjitJk_*DHOE+m6zhD1R^x|CB>p;)Cy+}p
zu5DmliEGkO!O9`^U?bjG4wOv1nlvu?d5tY17fERez2J?F>U-fAe8NK>GgTd*ErmUZ
zy}_v&&J7sV_s5`;<gGio*b5h^?C}<y?k<rc<;#@W*kF7YDu079BB7d;q&ZdxizZ-L
zpO143c&uHgFS)!v=lU1OtKn9X1e(<}_g!Joc*O29ftkAm_~j4@r6k1++2YRwQ+?d1
zCs6kYPppR(Ul#TvYoB$i6TWXURWtNB02lnk^R~5y@G0lVIwY39LgdVH2Ra76hC=37
r^<W=D9V`l)?uC3U*)^B@NFa({e?+54_}@*cXMg#YHC{<5CJ_Ds-z7Vp

literal 0
HcmV?d00001

diff --git a/tools/pounder21/schedulers/test-tests.tar.gz b/tools/pounder21/schedulers/test-tests.tar.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ddff53ee18b6c115b6cc0292f64a13abaccb048c
GIT binary patch
literal 1057
zcmV++1m61}iwFRrp*c<f1MOVjZ__Xk?sNZ&8|9I<wqrYhgm~!?lNd!%gm{{=#%&_H
zBuY})pO2j;Yz<vUt2k84eX5lHaN=t|pYOY~+gxRNHttykA%wX?m?L!sHAg}@FODU8
zlu9Zjqr$YKggK-K!me2xth3xp0sf(#N;CWBw2i#re@28KrnZK`zw$2~>Pr2bP|942
z{I`KE{%1rkyl~ZYABJGpbt}I2@=uA>{JSobJz%5JSU-%3SJ^xb6K$!nZ<Gbi8CUV2
z#&N#CT^IOw6EAE0TOQ0m)1Qmo{2Tj_|K?ERUz`m84)Wgyw)meA;;WlDqRsYE@V_Vi
z8_p@A(iPI>jvgnJNvZW8Y1WM0=y?1eoQ<!;Xq*LoH4kFg&=2OG<YBZN8T9+Vf^elE
zPuHsN$9(|(SkO1rJkxJPs{g;g1>#uL=l_$@e-Ffe)PK#Q&cAmZr+e?i5jZ0LI}ho<
z!oDU40P?Tzs=A%8*1q!XQ~>Vf|9ko8j?Vja;;-YsOWc<8f8^irZ(gp#tl1gB5G?Qb
z{)>Ny%NqY&=xLx`{nt_c2QUj1B<nPZGX?Pi@*vD$Vf3Cp<}v(GDuLX)&LEEZ1JF`%
z9zYVWBVVPEt*?s#1YWA38bq*2;~RY)rJI{iAzeo!_!g*0{nY1-#?{$FRb611$HVe;
zeUk22-);Yexkl9jBJW0l7x|EQc>qh5!zx}bm9N_eDpgvg4q!5ckJA}kPA3=dzQgSO
z#TR&Y@!@=g`t(6m@t@jA{7W3J|D>q&pWWoY*LnZ1_?IV9|7T>g{-fi7!1{k1*y4Xi
zURu-t`}miRssFf|d`F9cqW)v_Kh}TjqgMZUR^?Z(!JGd$gW_cvEzh3y)oqvq69R+j
zQ$o%EU!6+*pAoG8w}CDGtNK4{wvWf=|FZsX=6{|4kz)SmZRdZFw|kQOWBtF|sQEuF
z27uFS9|!oqL&Zk_anygUV3+?h^#9IaTmMmFP5<r7{}}z_|AH6(&(Z(e!9D*s`5i%5
z?iRNE-%<_u5dUY=)PI@I2GRf90Q!HoQIG%D_W$gy|K90;zRCYNL;r6D_4;qQzv?y2
z%sOzf@@n2vepLY;I*j8a@no>=|8@kxLGhm#{$H&Bq5s<l#{X`k@_%My;kU%W>pyxb
zaLA7RAB}JR?BV)P$v-z!|0<3X3w<21{^wBs!2Ta&Bkuog3>E*54dGwnaQ~N_(;fUb
zzWKk0{FnT@S-4yz%1R&i_<!{G-xdGT*}?zD#%4!A$MxTa{|O;kc$2Ku#6};FuKzJs
z{{Msd;ZL#upHTe$Un{uN|Ia^7zkZyYf4+J@y*wX>(ISk(TwR%X3)`R7e6kofoAd#m
bzr_Rsfj}S-2m}IwI9dD#?ssbA08jt`(w|Tl

literal 0
HcmV?d00001

diff --git a/tools/pounder21/test-tests.tar.gz b/tools/pounder21/test-tests.tar.gz
deleted file mode 100644
index fe3d576c115b61cefbda28552893c8af6f57e40e..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1006
zcmV<K0}=cmiwFR#N8~{O1MQnjPuoBgg|p7D7-+Xm=FU^1s=5KGo0h7gYZQnfZi5rW
zM)c>`<FN_0XhI^7N%8p<$$1!N?BjE1?mV(6&C>B8D4cU)wRT6cn%t3-QpK@kK>1I^
zl{6|pkA$&uz;xJZdG6C}vSMs7{q?X&Za1A5t<nwur@D~p_@9s!`d@H8jaQ)_gO}>h
zjpRi6?<B3T(7y|6`d@IGTrE~v%VoIxVXb|c|7Ct&{#NGx7o*X*sLv>!wOpk&(0{G}
zDd*GZZjn&CWfb~v@IP_m^fy);s|x+Klr&(S+{B*i|L$mf6({3#HjJ)k3+Cl#?w(|E
zayxPihYz!O9<gk79}TCAA!GULhCY#dmw%B&!`HqFurJN{e=~{aZI`ig{1>FT^6@`^
zxhh_!*Q<D$*VNUo)#jk*{%`8PoTQtsaxeDL--_q;clCq*?a|O*9EAVLXjS^Zb-y=(
z{!jIn2jPD*rt1H<?)N6pztG<tSpF|L^8YTV=^w)UgYEfW-rjrtwU)w|Tz_SxK>pVS
zPx8M%amF}Oxqeae|3#Ppu#^84cmB7^!2ewU|M#1^{{xQyZ}Pv9kN)RUx$$42E&SgF
zjq%^(YQE)!O|E|*vEpN#+#VhK_#m`Kgm_ET{QtW1KhFQcT3*cm5ZeDv!2D0YY4~3h
z4}fg9j2-+hNh|MvwEvy(oc{&<-y0hJe{mq=|9<^Xpz(+rJ@<b@e;I84Z)5(qj{nN{
z|F~6%|6S0`|H}E+6Lv9+Q|6uy=Dv!iRR;J$3Wa$8W@!39Sp0wC_^+Gz&;3t=!~b1?
z@!x*q{U3If%?sOqV~o(67xTY)1_=Lm0own5<Ncq;cguNn8mNpN`u`5+e<3vd-vtf-
zmk$D4-6u&o{xeMHQM6>lxeoyB{b%_9&EWkXc9+$5|I23kFBS6tPQd(czp3(n5n|y-
zN#XyU#(%ZZZvRK{&7Xtb``_z-%K3b;SOzL%Tl^PPt^X!vg<JovxIq5b3G4X({`>jQ
zZ>MKJF29_AJsZc#O`OD8bm^W8c3d<L<x^614nH#AGt|dy;~&?5t0f%hQNA`+{8w(^
zH&6`NJ^ovgCXfGBov{Bu7+(LdyR5eM|EuwTLz+yH|K}eN|GNO=|NW+l|2B<pZ<bMz
zGIoytf=HJ8e`}k+eI45kR6X~9rGJo(|0R3me^S}9{STb}L4U7*kcB@bd+0BWTmKb&
z^Zx+)KlcB^b+otj|A@r8|3}6853Vu)(+U5||Fifmn)>{mp3UIP*o+Jw0000000000
c000000000000000003TxzaV#_LI8LG05)VdHvj+t

diff --git a/tools/pounder21/testall-tests.tar.gz b/tools/pounder21/testall-tests.tar.gz
deleted file mode 100644
index 5a60a6fda24621fdbb9e71584eda87c3ac9b7515..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 314
zcmb2|=HU2}v&V^vxg@o?BrzvP7ep89l_VB1yuIY;-)tbl{vqz=@(QJLx#R<hH$6SS
z7^KU5PU1<7E)2~PPx$!y^cC5dM_-ycpZ(vxM=kf(^*`~eXKnlFx_(CG1ec5JiiGOd
z$-5kA)_7>a*S_(A!jnWL4Wa!Bx3{?Zs)Y6HU$d#HeYgAXU-xfc`!nu;I&X19w`<ia
z&3e0O^%AY@Klvvc2pl=FzkIp+KPTz>K$Gm5v3{2d&*&^Ix1Ae5ce(k`qa~Am?Y?+o
zcIsO5yDLgUH785&UcvQQB{ehq(h}avNUPInMX5^{d+$=dep#>gr0wpxJ4@^rm96b5
znX}Y%ty#3`B)^qQi$6@N3tPQsQ`zO%>!r@_QXfmcPYblq{I)lgkpT^SxW9*KMs{r;
Ig9ZZw0Evi`YXATM


--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev

--------------1.7.4.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.4.1--



