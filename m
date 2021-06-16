From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Jun 2021 13:56:12 +0200
Subject: [LTP] [PATCH 3/3] syscalls/getrusage: Convert getrusage01 to
 the new API
In-Reply-To: <20210616093606.214856-4-xieziyao@huawei.com>
References: <20210616093606.214856-1-xieziyao@huawei.com>
 <20210616093606.214856-4-xieziyao@huawei.com>
Message-ID: <YMnm3OaNEvej40JX@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with two changes, thanks.

* Changed the SPDX to GPL-2.0 since the original license was 2.0 only

* Changed the rusage buffer to guarded buffer

-- 
Cyril Hrubis
chrubis@suse.cz
