From: Sandeep Patil <sspatil@android.com>
Date: Sun, 9 Jun 2019 17:26:36 -0700
Subject: [LTP] [PATCH 5/5] syscalls/bind01: convert to new library.
In-Reply-To: <20190529115149.GA569@rei.lan>
References: <20190519003808.47425-1-sspatil@android.com>
 <20190519003808.47425-6-sspatil@android.com>
 <20190529115149.GA569@rei.lan>
Message-ID: <20190610002636.GC212690@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 29, 2019 at 01:51:49PM +0200, Cyril Hrubis wrote:
> Hi!
> Unfortunatelly this does not apply cleanly after:
> 
> commit fa6a4e708495d9177eca395717ebab4ee9afd8d6
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Tue Apr 23 21:38:23 2019 +0200
> 
>     net: Introduce TST_GET_UNUSED_PORT() macro into C API
> 
> 
> Can you please rebase your commit?

Done, v2 sent
