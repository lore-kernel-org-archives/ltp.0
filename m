From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jun 2021 15:42:17 +0200
Subject: [LTP] [RFC PATCH v2 0/2] Libclang based analyzer
In-Reply-To: <52c808d5-c5d7-3a79-122b-428fe2802957@jv-coder.de>
References: <20210604111434.21422-1-rpalethorpe@suse.com>
 <85bddc61-f6dc-de7c-3a62-daeefcd0a058@jv-coder.de>
 <87bl8i563x.fsf@suse.de>
 <52c808d5-c5d7-3a79-122b-428fe2802957@jv-coder.de>
Message-ID: <YL4iOWJj1e+foCNr@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > IIRC Cyril said the Coccinelle package on Gentoo is not maintained
> > anymore. AFAICT it exists, but it is on an old version. I don't think
> > many people are interested in or want to maintain Ocaml
> > stuff. LLVM/Clang OTOH looks to be very active.
> Right, it actually is removed now from gentoo portage tree ([1]). But is 
> it used by the kernel developers?

I guess that some people use it, however the choice of programming
language makes everthing much harder. On some distributions it's hard to
install and requires manual steps and when you hit a bug it's impossible
to debug unless you know how to debug ocaml. I've tried to fix a simple
bug in coccinelle once, but gave up after a few hours since I wasn't
even able to gasp how the source code is structured. And for the record
I used to read and write lisp and haskell just fine during my university
days. So even my skills in functional programming are rusty now I did
not expect that ocaml would be so alien to me...

-- 
Cyril Hrubis
chrubis@suse.cz
