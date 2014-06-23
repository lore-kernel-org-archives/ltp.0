Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz6Ur-0007VM-EA
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 15:49:29 +0000
Date: Mon, 23 Jun 2014 17:49:12 +0200
From: chrubis@suse.cz
Message-ID: <20140623154912.GC982@rei.suse.cz>
References: <1401286323-7364-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401286323-7364-1-git-send-email-alexey.kodanev@oracle.com>
Subject: Re: [LTP] [PATCH RFC] testscripts/network: uniform network
	parameters
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> diff --git a/testscripts/network.sh b/testscripts/network.sh
> new file mode 100755
> index 0000000..0b89c8e
> --- /dev/null
> +++ b/testscripts/network.sh
> @@ -0,0 +1,53 @@
> +#!/bin/sh
> +
> +# Network Test Parameters
> +#
> +# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
> +
> +export RHOST=
> +export PASSWD=
> +
> +# ---***************************************************---
> +
> +LTP_RSH=
> +
> +# Set names for test interfaces
> +LHOST_INTERFACE=
> +RHOST_INTERFACE=
> +
> +# Set first three octets of the network address
> +IPV4_NETWORK=
> +# Set local host last octet
> +LHOST_IPV4_HOST=
> +# Set remote host last octet
> +RHOST_IPV4_HOST=
> +# Set the reverse of IPV4_NETWORK
> +IPV4_NETWORK_REVERSE=
> +# Set firt three octets of the network address
> +IPV6_NETWORK=
> +# Set local host last octet
> +LHOST_IPV6_HOST=
> +# Set remote host last octet
> +RHOST_IPV6_HOST=
> +
> +export HTTP_DOWNLOAD_DIR=
> +export FTP_DOWNLOAD_DIR=
> +export FTP_UPLOAD_DIR=
> +export FTP_UPLOAD_URLDIR=
> +
> +# Set default parameters
> +export LTP_RSH=${LTP_RSH:-"rsh -n"}
> +export LHOST_INTERFACE=${LHOST_INTERFACE:-"eth0"}
> +export RHOST_INTERFACE=${RHOST_INTERFACE:-"eth0"}
> +export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
> +export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
> +export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
> +export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
> +export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
> +export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
> +export IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
> +
> +export TMPDIR=/tmp/netpan-$$
> +mkdir -p $TMPDIR
> +CMDFILE=${TMPDIR}/network.tests
> +VERBOSE="no"

A bit more documentation how to setup these would not harm. Do we have a
document that describes this?

> diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
> index b40af72..7536d3f 100755
> --- a/testscripts/networkstress.sh
> +++ b/testscripts/networkstress.sh
> @@ -12,32 +12,10 @@ if [ $? -eq 0 ]; then
>   export LTPROOT=${PWD}
>  fi
>  
> -export TMPDIR=/tmp/netst-$$
> -mkdir $TMPDIR
> -VERBOSE="no"
> -INTERFACE="eth0"
> -
> -#===========================================================================
> -# Network parameters
> -export RHOST=
> -export RHOST_HWADDRS=
> -export HTTP_DOWNLOAD_DIR=
> -export FTP_DOWNLOAD_DIR=
> -export FTP_UPLOAD_DIR=
> -export FTP_UPLOAD_URLDIR=
> -
> -# Set firt three octets of the network address, by default 10.0.0
> -export IPV4_NETWORK=
> -# Set local host last octet, by default 2
> -export LHOST_IPV4_HOST=
> -# Set remote host last octet, by default 1
> -export RHOST_IPV4_HOST=
> -# Set the reverse of IPV4_NETWORK, by default 0.0.10
> -export IPV4_NETWORK_REVERSE=
> +. $LTPROOT/testscripts/network.sh $0
>  
>  #===========================================================================
>  # Default Test Settings
> -# export LTP_RSH=rsh
>  # export NS_DURATION=3600	# 1 hour
>  # export NS_TIMES=10000
>  # export CONNECTION_TOTAL=4000
> @@ -102,8 +80,6 @@ if [ -z ${TEST_CASE} ]; then
>  	usage
>  fi
>  
> -export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk '{print $5}'`
> -
>  if [ -z ${RHOST} ]; then
>  	## Just a silly check
>  	echo "Error: pay attention to configure"
> @@ -111,6 +87,11 @@ if [ -z ${RHOST} ]; then
>  	exit 1
>  fi
>  
> +export LHOST_HWADDRS=$(/sbin/ifconfig | grep $LHOST_INTERFACE |\
> +	grep HWaddr | awk '{print $5}')
> +export RHOST_HWADDRS=$($LTP_RSH $RHOST /sbin/ifconfig |\
> +	grep $RHOST_INTERFACE | grep HWaddr | awk '{print $5}')
> +

Calling ifconfig by full path is broken, Gentoo (and possible others)
has ifconfig in /bin/ (and you are allowed to call it as user to query
device configuration).

Moreover we may want to create a script to query interface IP and HWaddr
(and possibly others we may need) because ifconfig is deprecated and
some distros does not install it by default. If we move it to a library
we may write a code to use either ifconfig of ip depending on what is
available.

>  cat ${LTPROOT}/runtest/${TEST_CASE} > $TMPDIR/network_stress.tests
>  
>  cd $TMPDIR
> @@ -119,9 +100,8 @@ export PATH="${PATH}:${LTPROOT}/testcases/bin"
>  
>  if [ ${VERBOSE} = "yes" ]; then
>  	echo "Network parameters:"
> -	echo " - ${INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
> -	echo " - Remote IP address: ${RHOST}"
> -	echo " - Remote MAC address: ${RHOST_HWADDRS}"
> +	echo " - ${LHOST_INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
> +	echo " - ${RHOST_INTERFACE} remote interface (MAC address: ${RHOST_HWADDRS})"
>  
>  	cat $TMPDIR/network_stress.tests
>  	${LTPROOT}/ver_linux
> diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
> index b136749..507b7e3 100755
> --- a/testscripts/networktests.sh
> +++ b/testscripts/networktests.sh
> @@ -1,11 +1,6 @@
>  #!/bin/sh
>  # This will run all the network tests, with the status logged in /tmp/netpan.log
>  
> -# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
> -export RHOST=
> -export PASSWD=
> -# ---***************************************************---
> -
>  cd `dirname $0`
>  export LTPROOT=${PWD}
>  echo $LTPROOT | grep testscripts > /dev/null 2>&1
> @@ -14,10 +9,7 @@ if [ $? -eq 0 ]; then
>   export LTPROOT=${PWD}
>  fi
>  
> -export TMPDIR=/tmp/netpan-$$
> -mkdir -p $TMPDIR
> -CMDFILE=${TMPDIR}/network.tests
> -VERBOSE="no"
> +. $LTPROOT/testscripts/network.sh $0
>  
>  # For bitwise operation to determine which testsets run
>  CMD_IPV6=1		# 0x0001

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
