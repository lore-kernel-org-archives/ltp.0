From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jun 2020 11:07:18 +0800
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <CAEemH2fkUX2KA+dPqgjqrBftxAZ722k9B7i3fi8eSxEmzSLk6w@mail.gmail.com>
References: <20200609095102.21153-1-liwang@redhat.com>
 <1111554317.15300411.1591699362992.JavaMail.zimbra@redhat.com>
 <CAEemH2fkUX2KA+dPqgjqrBftxAZ722k9B7i3fi8eSxEmzSLk6w@mail.gmail.com>
Message-ID: <CAEemH2e+BE4=jikyu92CNarVGefd9piwDdWxSzwua3rWj6_dkQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have pushed the patchset with the following changes:

1. use SAFE_MALLOC to replace SAFE_MMAP
2. set 1 to cgroup.clone_children before creating dir
3. add more code comments in tst_cgroup.h

Let's see how things going on with these new APIs using in next.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200619/d1645c69/attachment.htm>
