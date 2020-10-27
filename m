From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Oct 2020 16:45:29 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <874kmfvg3q.fsf@suse.de>
References: <20201027110446.20416-1-chrubis@suse.cz>
 <20201027110446.20416-2-chrubis@suse.cz> <874kmfvg3q.fsf@suse.de>
Message-ID: <20201027154529.GA20643@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +/*
> > + * Note that we avoid modifying the list until the end so that the caller can
> > + * free memory correctly, which is the reason we have a stack for
> > parentesis
> 
> If you use a new vector/stack for the output queue instead of an
> intrusive list then this problem should go away. We have an upper bound
> for any token/expr vector which is the length of the input string. So it
> is possible to preallocate an input array instead of using a dynamically
> allocated linked list.

Or we can run the tokenizer twice and first time only record number of
tokens...

-- 
Cyril Hrubis
chrubis@suse.cz
