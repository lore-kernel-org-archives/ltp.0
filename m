From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 6 Mar 2020 08:12:21 +0100
Subject: [LTP] [PATCH] hugeshmctl01: Revert "hugeshmctl: Use loop from
 the API"
In-Reply-To: <CAEemH2f+tOCEm=6k9p+xZNAKgKcCu95ZdDdyy1RQqtqRYD+zOA@mail.gmail.com>
References: <1583402023-22461-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200305172142.GA24302@dell5510>
 <CAEemH2f+tOCEm=6k9p+xZNAKgKcCu95ZdDdyy1RQqtqRYD+zOA@mail.gmail.com>
Message-ID: <20200306071221.GA13530@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Xu,
> > I'd personally prefer to keep .tcnt = ARRAY_SIZE(tcases),

> +1 Me too. I don't think we should revert the patch. Just fix the problem
> and do refactor or improvement will make the code more readable.

Thank you both for review and additional info.
Xu, you did the original debugging, so feel free to send a patch which just
fixes the problem.

Kind regards,
Petr
