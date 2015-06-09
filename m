Return-Path: <sitelist-bounces@lists.sourceforge.net>
Subject: Ltp-list post from mhocko@suse.cz requires approval
From: ltp-list-owner@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3503466547357584426=="
Message-ID: <mailman.272239.1433852796.2287.ltp-list@lists.sourceforge.net>
Date: Tue, 09 Jun 2015 12:26:36 +0000
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
Errors-To: sitelist-bounces@lists.sourceforge.net
To: ltp-list-owner@lists.sourceforge.net

--===============3503466547357584426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

As list administrator, your authorization is requested for the
following mailing list posting:

    List:    Ltp-list@lists.sourceforge.net
    From:    mhocko@suse.cz
    Subject: ltp: thp04.c test case
    Reason:  Post by non-member to a members-only list

At your convenience, visit:

    https://lists.sourceforge.net/lists/admindb/ltp-list
        
to approve or deny the request.

--===============3503466547357584426==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mhocko@suse.cz>) id 1Z2Ibz-00062P-AZ
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sourceforge.net; s=x; 
	h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
	bh=0MHsBufQMSRwuS34ECWXFtjRmA6943udF7+EIwKUlns=; 
	b=dstrtaxMyMBfL76IRyzYrpWXmrJ3R8c2/SHLmT8ZKIVPbzs+0X/BnCXmQKziKaMjCkePwHfo/oMmRt2ytBcQ4puNq8eQFOYvvfSnzd8hWwvNeNLlTJNq99yZUFPU2S9RRlbJiQJU2hMRyGrVHAVXAoYfKyyqiV1myeWyQtsIB2k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x;
	h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date;
	bh=0MHsBufQMSRwuS34ECWXFtjRmA6943udF7+EIwKUlns=; 
	b=CoiCNsMJOxGT8OcylsozI/BJqW3BQ5I+moUjiYWHhxKTnYhilasYT0qqr2+mtDOJyJKPP/YSdbf8TPMTzbByy4ushXf45d+ogZPgltTi1vlpDdwvVTa6b8+bA+bAIkHaS1Py5eFR4patdBNjVl03qTTL4iUy2ygVLCtJ+873I5g=;
X-ACL-Warn: 
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z2Iby-0007qn-Bb
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2015 12:26:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 05881ADCE;
	Tue,  9 Jun 2015 12:26:28 +0000 (UTC)
Date: Tue, 9 Jun 2015 14:26:28 +0200
From: Michal Hocko <mhocko@suse.cz>
To: Zhouping Liu <zliu@redhat.com>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, ltp-list@lists.sourceforge.net,
	Cyril Hrubis <chrubis@suse.cz>, Vlastimil Babka <vbabka@suse.cz>
Subject: ltp: thp04.c test case
Message-ID: <20150609122628.GE29057@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-0.0 AWL AWL: Adjusted score from AWL reputation of From: address
X-Headers-End: 1Z2Iby-0007qn-Bb

Hi,
our QA has just encountered that testcases/kernel/mem/thp/thp04.c
test case is failing in their testing environment. That made me look
into what the test is doing actually and I have to say that I am quite
confused about what is the objective here.

I think the test is simply misleading. You cannot expect 100% success
rate for the THP pages. System memory might be fragmented and THP
allocation might fail even when there is sufficient memory available.
So from my perspective the test is simply bogus because its success rate
highly depends on the current state of the system and a so the failure
doesn't really mean a bug/misbehavior of the kernel.

But before I suggest dropping this test I would have some questions.
What has motivated the test case originally? What a failure would tell
the tester?
Under which conditions is the test supposed to be run? Fresh boot, idle
syste, system under a light load?
It is also not clear whether the testcase is supposed to test page fault
THP path or khugepaded.

I think it would make much more sense to test THP success rate with a
different variety of workloads to see how well is the mm code able to
cope with different levels of fragmentation and collect that data over
time to potentially notice regressions. This however doesn't fit well
inside LTP project which is stateless AFAIU (but my understanding is
very limited).

Thanks!
-- 
Michal Hocko
SUSE Labs


--===============3503466547357584426==
Content-Type: message/rfc822
MIME-Version: 1.0

Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: confirm 580e47122891f98d043145f27644881fda791f27
Sender: ltp-list-request@lists.sourceforge.net
From: ltp-list-request@lists.sourceforge.net

If you reply to this message, keeping the Subject: header intact,
Mailman will discard the held message.  Do this if the message is
spam.  If you reply to this message and include an Approved: header
with the list password in it, the message will be approved for posting
to the list.  The Approved: header can also appear in the first line
of the body of the reply.
--===============3503466547357584426==--

