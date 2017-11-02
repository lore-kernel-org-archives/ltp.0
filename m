From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Nov 2017 11:11:09 +0100
Subject: [LTP] [PATCH v3 1/2] ltp: fix some frequent typoes
In-Reply-To: <CAEemH2eEGxZnmPEwSQ5buV=5RTaRuj2qUhDb1m9JGBi7+qYvhg@mail.gmail.com>
References: <20171101051523.373-1-liwang@redhat.com>
 <20171101134356.GA10818@rei.lan>
 <CAEemH2eEGxZnmPEwSQ5buV=5RTaRuj2qUhDb1m9JGBi7+qYvhg@mail.gmail.com>
Message-ID: <20171102101109.GA18583@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Since the rest of the changes are just fixing typos, there is no change
> > in behaivor. But this one actually changes it and there is even no
> > description for it in the commit message.
> 
> Sorry, I feel a little confused.
> 
> This typo only in the printed messages but without any behavior changing too.
> The situation is that if execl() get failed and then tst_brk do exist
> with the typo print.

My bad, I was blind yesterday evening and confused the line in the
message with the line that actually calls the syscall. I will take the
patch as it is and sorry for the confusion.

-- 
Cyril Hrubis
chrubis@suse.cz
