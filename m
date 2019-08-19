From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Aug 2019 16:26:44 +0800
Subject: [LTP] [PATCH ltp] testcases/kernel/Makefile: remove 'timer'
 from Android FILTER_OUT_DIRS
In-Reply-To: <20190819065928.26939-1-yixin.zhang@intel.com>
References: <20190819065928.26939-1-yixin.zhang@intel.com>
Message-ID: <CAEemH2d+PX0VLN5kSnx5G=W7h-uBVZdtEQxNbgsi5P6YwTT83Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 19, 2019 at 3:10 PM Yixin Zhang <yixin.zhang@intel.com> wrote:
>
> 'timer' folder is removed in 0051eab232e7f777f435945b1aba8911f203d65b.
> Remove it from FILTER_OUT_DIRS for Android

Good catch, pushed.

-- 
Regards,
Li Wang
