Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ego@linux.vnet.ibm.com>) id 1NUCEu-0003Gx-SR
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 04:50:52 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUCEt-0004kj-71
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 04:50:52 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o0B4oXa7001452
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 15:50:33 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0B4k1jr1597596
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 15:46:01 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0B4oWpt028433
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 15:50:32 +1100
Date: Mon, 11 Jan 2010 10:20:31 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
Message-ID: <20100111045031.GB1428@in.ibm.com>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
	<20091224181551.12571.4910.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091224181551.12571.4910.sendpatchset@localhost.localdomain>
Subject: Re: [LTP] [Patch 3/4]Python functions modified to run on Power
	platform
Reply-To: ego@in.ibm.com
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
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, arun@linux.vnet.ibm.com

On Thu, Dec 24, 2009 at 11:45:51PM +0530, Poornima Nayak wrote:
> +def get_hyper_thread_count():
> +    ''' Return number of threads in cpu0
> +    '''
> +    try:
> +        file_cpuinfo = open("/sys/devices/system/cpu/cpu0/topology/thread_siblings", 'r')
> +        threads_count = 0
> +        for line in file_cpuinfo:
> +            core_grps = line.split(",")
> +            for i in range(0, len(core_grps)):
> +                cpumask=int(core_grps[i])
> +                while cpumask > 0:
> +                    threads_count = threads_count + 1
> +                    cpumask = cpumask >> 1
> +        return threads_count
> +    except Exception, details:
> +        print "INFO: Failed to get threaded siblings count", details
> +        sys.exit(1)
> +
> +def get_core_sibling_count():
> +    ''' Return number of threads in cpu0
> +    '''
> +    try:
> +        file_cpuinfo = open("/sys/devices/system/cpu/cpu0/topology/core_siblings", 'r')
> +        cores_count = 0
> +        for line in file_cpuinfo:
> +            core_grps = line.split(",")
> +            for i in range(0, len(core_grps)):
> +                cpumask=int(core_grps[i])
> +                while cpumask > 0:
> +                    cores_count = cores_count + 1
> +                    cpumask = cpumask >> 1
> +        return cores_count
> +    except Exception, details:
> +        print "INFO: Failed to get core siblings count", details
> +        sys.exit(1)
> +

We could avoid the code repetition above.

def get_entity_count(entity):
	try:
		file_cpuinfo =
		open("/sys/devices/system/cpu/cpu0/topology/" + entity + "siblings", 'r)
		.
		.
		.
	except
		.
		.
		.

def get_hyper_thread_count():
	return get_entity_count("thread")

def get_core_sibling_count():
	return get_entity_count("core")



-- 
Thanks and Regards
gautham

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
