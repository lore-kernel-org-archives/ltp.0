Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1S3S3J-0002qu-F7
	for ltp-list@lists.sourceforge.net; Fri, 02 Mar 2012 12:57:41 +0000
Date: Fri, 2 Mar 2012 13:58:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120302125851.GA8394@saboteur.suse.cz>
References: <loom.20120228T103647-261@post.gmane.org>
	<20120229162236.GA29987@saboteur.suse.cz>
	<6F91E0FFDA542149961F7BDED2D2B94B549365C4B6@EXGMBX01.sasken.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6F91E0FFDA542149961F7BDED2D2B94B549365C4B6@EXGMBX01.sasken.com>
Subject: Re: [LTP] Need help in cross compiling LTP for android
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
To: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> + LOGFILE_NAME=2012_Mar_02-14h_25m_52s
> + LOGFILE=-l /data/ltp/make_2802_02_2012/results/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.log
> + ALT_DIR_RES=1
> + PRETTY_PRT= -p
> + [ !  ]
> + ALT_DIR_OUT=1
> + [ !  ]
> + [ ! -l /data/ltp/make_2802_02_2012/results/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.log ]
> + basename 2012_Mar_02-14h_25m_52s
> + FAILED_FILE_NAME=2012_Mar_02-14h_25m_52s
> + FAILCMDFILE=-C /data/ltp/make_2802_02_2012/output/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.failed
> + [ 0 -eq 1 ]
> + [ 1 -eq 1 ]
> + [ ! -d /data/ltp/make_2802_02_2012/output ]
> + [ 1 -eq 1 ]
> + echo INFO: creating /data/ltp/make_2802_02_2012/results directory
> INFO: creating /data/ltp/make_2802_02_2012/results directory
> + [ ! -d /data/ltp/make_2802_02_2012/results ]
> + mkdir -m 777 -p /data/ltp/make_2802_02_2012/tmp
> mkdir failed for -m, File exists
> + echo FATAL: Unable to make temporary directory /data/ltp/make_2802_02_2012/tmp
> FATAL: Unable to make temporary directory /data/ltp/make_2802_02_2012/tmp

Hmm, this is strange, mkdir -p must not fail with 'File exists'. 

> + export TMPTEMPLATE=/data/ltp/make_2802_02_2012/tmp/ltp-XXXXXXXXXX
> + mktemp -d /data/ltp/make_2802_02_2012/tmp/ltp-XXXXXXXXXX
> + TMP=/data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
> + export TMP
> + export TMPDIR=/data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
> + chmod 777 /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
> + cd /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
> + [ -n  ]
> + [ 0 -eq 1 ]
> + [ -z  ]
> + [ -z  ]
> + cat
> + + cat /data/ltp/make_2802_02_2012/scenario_groups/default
> tr \012

...

> + rm -f /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460/cat_ok.3443
> rm failed for -f, No such file or directory

And this is even much more wrong.

I'm not familiar with android but this sugests that you have very
crippled busybox or whatever is installed there to provide basic
commands like rm, mkdir and so.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
