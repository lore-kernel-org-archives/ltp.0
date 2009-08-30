Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoKm-0001VG-8k
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:36:56 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoKg-0001pz-Hu
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:36:56 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHSLCZ026783
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:28:21 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHagV2240256
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:36:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHafkm000671
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:36:42 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:06:29 +0530
Message-Id: <1251653791.12120.19.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 1/8] New testcase to validate Ideal Load
	Balancer	Functionality
Reply-To: subrata@linux.vnet.ibm.com
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Fri, 2009-08-28 at 15:44 +0530, Poornima Nayak wrote: 
> New testcase to validate Ideal Load Balancer Functionality.
> By default sets sched_mc_power_savings & sched_smt_power savings to the value
> passed as argument and then triggers kernbench by pinning it to the CPUn
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Done. Thanks.

Regards--
Subrata

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/ilb_test.py ltp/testcases/kernel/power_management/ilb_test.py
> --- ltp_orig/testcases/kernel/power_management/ilb_test.py	1970-01-01 05:30:00.000000000 +0530
> +++ ltp/testcases/kernel/power_management/ilb_test.py	2009-08-28 12:13:27.000000000 +0530
> @@ -0,0 +1,57 @@
> +#!/usr/bin/python
> +''' This Python script interprets interrupt values.
> +    Validates Ideal load balancer runs in same package where workload is running
> +'''
> +
> +import os
> +import sys
> +LIB_DIR = "%s/testcases/kernel/power_management/lib" % os.environ['LTPROOT']
> +sys.path.append(LIB_DIR)
> +from optparse import OptionParser
> +from sched_mc import *
> +
> +__author__ = "Poornima Nayak <mpnayak@linux.vnet.ibm.com>"
> +
> +class Usage(Exception):
> +    def __init__(self, msg):
> +        self.msg = msg
> +
> +def main(argv=None):
> +    if argv is None:
> +        argv = sys.argv
> +
> +    usage = "-w"
> +    parser = OptionParser(usage)
> +    parser.add_option("-c", "--mc_level", dest="mc_level",
> +        default=0, help="Sched mc power saving value 0/1/2")
> +    parser.add_option("-t", "--smt_level", dest="smt_level",
> +        default=0, help="Sched smt power saving value 0/1/2")
> +    parser.add_option("-w", "--workload", dest="work_ld",
> +        default="kernbench", help="Workload can be ebizzy/kernbench")
> +    (options, args) = parser.parse_args()
> +
> +    try:
> +        count_num_cpu()
> +        count_num_sockets()
> +        if is_multi_socket():
> +            set_sched_mc_power(options.mc_level)
> +        if is_hyper_threaded():
> +            set_sched_smt_power(options.smt_level)
> +        map_cpuid_pkgid()
> +        print "INFO: Created table mapping cpu to package"
> +        background="no"
> +        duration=60
> +        pinned="yes"
> +        trigger_workld(options.work_ld, "single_job", duration, background, pinned)
> +        generate_loc_intr_report()
> +        status = validate_ilb(options.mc_level, options.smt_level)
> +        reset_schedmc()
> +        if is_hyper_threaded():
> +            reset_schedsmt()
> +        return(status)        
> +    except Exception, details:
> +        print "INFO: Idle Load Balancer test failed", details
> +        return(1)
> +
> +if __name__ == "__main__":
> +    sys.exit(main())
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
