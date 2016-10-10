From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 10 Oct 2016 08:43:49 -0400 (EDT)
Subject: [LTP] typo in commit message
In-Reply-To: <20161010123034.GA1478@rei>
References: <20161010123034.GA1478@rei>
Message-ID: <1069384844.2648.1476103429058.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Monday, 10 October, 2016 2:30:34 PM
> Subject: [LTP] typo in commit message
> 
> Hi!
> I've did a confusing typo in commit:
> https://github.com/linux-test-project/ltp/commit/ebfb34503c7928368043182a2ac7750e805c4911
> 
> There is no such thing as ppc32le of course, it should have been
> ppc64le. Is everyone OK with me force pushing with the simple change in
> the commit message?

I would prefer to avoid force push, specially when we don't know
how many people already cloned it.

How about we do a revert and apply fixed patch instead?

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
