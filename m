From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Apr 2021 15:22:22 +0800
Subject: [LTP] [PATCH v3 4/7] Add new CGroups API library tests
In-Reply-To: <20210412145506.26894-5-rpalethorpe@suse.com>
References: <20210412145506.26894-1-rpalethorpe@suse.com>
 <20210412145506.26894-5-rpalethorpe@suse.com>
Message-ID: <CAEemH2c5i_zj-cm7bZrRAZBkA2gqdR7CtzBoxJWTZxCObMK7Vg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

>  lib/newlib_tests/.gitignore     |  2 +
>  lib/newlib_tests/test21.c       | 45 ++++++++---------
>  lib/newlib_tests/tst_cgroup01.c | 51 +++++++++++++++++++
>  lib/newlib_tests/tst_cgroup02.c | 90 +++++++++++++++++++++++++++++++++
>

Since test21 is covered by tst_cgroup02, I'd suggest deleting test21.c
directly.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210416/63ff23f7/attachment.htm>
