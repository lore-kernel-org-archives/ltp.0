From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 18 Apr 2017 06:00:21 -0400 (EDT)
Subject: [LTP] [PATCH] controllers/cpuset:check for cpuset mount status
 and prefix
In-Reply-To: <51ca2a88-aaac-1ea1-22fc-30c0a99bcd1b@linux.vnet.ibm.com>
References: <1468479240-4975-1-git-send-email-shuang.qiu@oracle.com>
 <757741255.7369133.1469193307743.JavaMail.zimbra@redhat.com>
 <51ca2a88-aaac-1ea1-22fc-30c0a99bcd1b@linux.vnet.ibm.com>
Message-ID: <2114709909.28213922.1492509621766.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> >> * Update to handle the env that cpuset subsystem is already mounted
> > I'm assuming motivation here are systemd distros, that have memory
> > cgroup already mounted.
> >
> I have tested with this patch on my RHEL7.3 system,and all tests passed.
> Can this patch be pulled to upstream ?

Cyril,

any objections to the patch?

I noticed one issue, but it's not related to this patch:
 /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 131: tst_kvercmp2: command not found
 /opt/ltp/testcases/bin/cpuset_base_ops_testset.sh: line 167: tst_kvercmp2: command not found

Regards,
Jan
