From: Li Wang <liwang@redhat.com>
Date: Tue, 25 Aug 2020 15:07:29 +0800
Subject: [LTP] [PATCH] cpuset_inherit_test: Add cgroup.clone_children
 swith for cpuset.cpus and mems
In-Reply-To: <b0e940e7-945b-cdd9-695d-025bdc4a1ba1@cn.fujitsu.com>
References: <1597042181-12722-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <b0e940e7-945b-cdd9-695d-025bdc4a1ba1@cn.fujitsu.com>
Message-ID: <CAEemH2dds8rJetEKXfwm5ck_knxOG=QFssbWtiRbxQk4oiZDVQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

I helped correct the test counting and pushed after self-testing.

------------

-# Case 1-3
+# Case 1-6
 test_cpus

-# Case 4-6
+# Case 7-12
 test_mems

-# Case 7-14
+# Case 13-20
 test_three_result_similar_flags

-# Case 15-18
+# Case 21-24
 test_spread_flags

-# Case 19-20
+# Case 25-26
 test_sched_load_balance_flag

-# Case 21-27
+# Case 27-33
 test_domain

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200825/755f6c4f/attachment.htm>
