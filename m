From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 Jun 2019 14:42:19 +0200
Subject: [LTP] [PATCH v3] syscalls/rt_sigqueueinfo01: rewrote testcase
In-Reply-To: <20190509074134.GA22704@dell5510>
References: <20190508112822.27255-1-camann@suse.com>
 <20190509074134.GA22704@dell5510>
Message-ID: <20190612124219.GA27163@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> > The previous implementation only tested if the syscall can
> > be called at all. Now it also checks if the correct signal
> > and data is sent and received.

> > Signed-off-by: Christian Amann <camann@suse.com>
> Acked-by: Petr Vorel <pvorel@suse.cz>

Merged, thanks for your work!

Kind regards,
Petr
