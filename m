From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 20 Apr 2017 14:15:22 +0200
Subject: [LTP] [PATCH] controllers/cpuset:check for cpuset mount status
 and prefix
In-Reply-To: <2114709909.28213922.1492509621766.JavaMail.zimbra@redhat.com>
References: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
 <757741255.7369133.1469193307743.JavaMail.zimbra@redhat.com>
 <51ca2a88-aaac-1ea1-22fc-30c0a99bcd1b@linux.vnet.ibm.com>
 <2114709909.28213922.1492509621766.JavaMail.zimbra@redhat.com>
Message-ID: <20170420121521.GB10246@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> any objections to the patch?

I looked at the patchset and pointed out some minor issues. Looks good
to me if these are fixed.

> I noticed one issue, but it's not related to this patch:
>  /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 131: tst_kvercmp2: command not found
>  /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 167: tst_kvercmp2: command not found

Ah, my bad, that is a leftover from the commit that removed the
tst_kvercmp* binaries. I will look into fixing it.

-- 
Cyril Hrubis
chrubis@suse.cz
