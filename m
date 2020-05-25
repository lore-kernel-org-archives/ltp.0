From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 25 May 2020 06:47:23 +0200
Subject: [LTP] [PATCH] crash02: Blacklist the pause() syscall
In-Reply-To: <20200521110110.11381-1-mdoucha@suse.cz>
References: <20200521110110.11381-1-mdoucha@suse.cz>
Message-ID: <20200525044723.GA7651@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> pause() causes the calling process/thread to sleep indefinitely until waken up
> by a signal. This will cause test timeouts.

Thanks, pushed!

Kind regards,
Petr
