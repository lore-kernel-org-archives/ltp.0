From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Oct 2018 11:47:11 +0200
Subject: [LTP] [PATCH] Correct the kernel_bits value in x86 PER_LINUX32.
In-Reply-To: <20181001171116.235573-1-kmagic@google.com>
References: <20181001171116.235573-1-kmagic@google.com>
Message-ID: <20181008094710.GA12510@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kenneth,

> From: Kenneth Magic <kmagic@google.com>

> Android runs all 32bit programs in a PER_LIINUX32 personality
> even under a 64 bit kernel, causing the machine to show up as
> "i686". Check for and correct this case so tests use the correct
> kernel_bits value.

> Signed-off-by: Kenneth Magic <kmagic@google.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>


Kind regards,
Petr
