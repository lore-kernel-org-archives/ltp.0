From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Oct 2020 09:00:17 +0200
Subject: [LTP] [PATCH 1/1] fanotify16: Introduce SAFE_FANOTIFY_MARK()
 macro
In-Reply-To: <CAOQ4uxixzOtXjyVTUNR03ffJHgTQCm5+L46zNNgdxvB0n9ZuhA@mail.gmail.com>
References: <20201016112441.4838-1-pvorel@suse.cz>
 <CAOQ4uxixzOtXjyVTUNR03ffJHgTQCm5+L46zNNgdxvB0n9ZuhA@mail.gmail.com>
Message-ID: <20201020070017.GA4263@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

thanks for your suggestions, I'll send v2 shortly.
I've been thinking about it for a while and agree it's better to simplify
safe_fanotify_mark() hints.
I'll also separate fixes into more commits to be more readable.

Kind regards,
Petr
