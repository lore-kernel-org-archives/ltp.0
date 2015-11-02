From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 2 Nov 2015 12:54:19 +0100
Subject: [LTP] [PATCH 6/11] mmap/mmap12: Testcase failed when no root
 user run it
In-Reply-To: <322055225.38333.1446279322374.JavaMail.zimbra@redhat.com>
References: <1446001907-43525-1-git-send-email-cuibixuan@huawei.com>
 <1446001907-43525-6-git-send-email-cuibixuan@huawei.com>
 <20151029115746.GA23990@rei> <563330C4.2060809@huawei.com>
 <492224674.39010592.1446197341093.JavaMail.zimbra@redhat.com>
 <5634112F.1030203@huawei.com>
 <322055225.38333.1446279322374.JavaMail.zimbra@redhat.com>
Message-ID: <20151102115419.GA28478@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> So I'm thinking that we should check "if euid != 0 and opening pagemap gives EPERM",
> then quit with TCONF.

Sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
