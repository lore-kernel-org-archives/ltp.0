Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sachinp@in.ibm.com>) id 1NpMlr-0003IJ-Eq
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 14:20:23 +0000
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NpMlq-0007pi-1K
	for ltp-list@lists.sourceforge.net; Wed, 10 Mar 2010 14:20:23 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp06.in.ibm.com (8.14.3/8.13.1) with ESMTP id o2AEKBVZ008848
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 19:50:11 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2AEKBaE3260416
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 19:50:11 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2AEKANl010620
	for <ltp-list@lists.sourceforge.net>; Wed, 10 Mar 2010 19:50:11 +0530
Message-ID: <4B97AA99.7050406@in.ibm.com>
Date: Wed, 10 Mar 2010 19:50:09 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
Subject: [LTP] LTP Containers netns test failure.
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
To: ltp-list@lists.sourceforge.net
Cc: serue@linux.vnet.ibm.com

NETNS tests from containers fails to execute with following
message

Running netns tests.
--: childns.sh '/opt/ltp': No such file or directory

Looking at the code the problem could be with create_net_namespace()
within netns/common.c

If i make the following changes the first subtest works fine but then
i ran into other failures related to other sub tests.

@@ -92,7 +92,7 @@ int create_net_namespace(char *p1, char
        }

        /* We need to pass the child pid to the parentns.sh script */
-       sprintf(par, "parentns.sh '%s' %s %" PRId32 , ltproot, p1, pid);
+       sprintf(par, "%s/testcases/bin/parentns.sh %s %" PRId32 , ltproot, p1, pid);

        ret = system(par);
        status = WEXITSTATUS(ret);
@@ -141,7 +141,7 @@ int child_fn(void *c1)
                exit(1);
        }

-       sprintf(child, "childns.sh '%s'", ltproot);
+       sprintf(child, "%s/testcases/bin/childns.sh", ltproot);

As i don't know the code too much .. i am not sure how to fix it.

Any ideas ?


Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
