From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Nov 2018 10:40:06 +0100
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
 <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com>
Message-ID: <20181105094005.GA8687@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Can you help me understand why you don't want to allow this test case to 
> make use of the C99 programming language?
> 
> It is only a 19 year old standard.
> 
> If there is a problem with C99 use, can you indicate that the problem is?

What I'm trying to say is:

* Reasonable recent compilers support c99 features without -c99
  explicitelly passed on command line

* It's a very bad idea to hardcode switches in random leaf Makefiles
  as from maintenance point of view this is real disaster

If we ever want to stick to some C standard it has to be a top level
decision, but honestly I do prefer the compiler defaults.

-- 
Cyril Hrubis
chrubis@suse.cz
