From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Dec 2020 18:05:27 +0100
Subject: [LTP] [PATCH] ltp-pan: Use long long int to print time_t
In-Reply-To: <20201221212501.GB4453@pevik>
References: <20201221061415.2540216-1-raj.khem@gmail.com>
 <20201221212501.GB4453@pevik>
Message-ID: <20201222170527.GA126602@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Khem,

> > Some newer 32bit architectures ( e.g. riscv32 ) uses 64bit time_t so
> > using %ld is not sufficient to print time_t, this also fixes a crash in
> > ltp-pan on riscv32

Merged, thanks!

Kind regards,
Petr
