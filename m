From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 25 Mar 2021 18:55:41 +0100
Subject: [LTP] [PATCH 3/3] lib/vdso: remove struct arch_vdso_data from
 vdso data struct
In-Reply-To: <20210323215819.4161164-4-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <20210323215819.4161164-4-hca@linux.ibm.com>
Message-ID: <87sg4jw21u.fsf@nanos.tec.linutronix.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 23 2021 at 22:58, Heiko Carstens wrote:
> Since commit d60d7de3e16d ("lib/vdso: Allow to add architecture-specific
> vdso data") it is possible to provide arch specific VDSO data.
>
> This was only added for s390, which doesn't make use this anymore.
> Therefore remove it again.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Please route that with the rest of the fixes.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
