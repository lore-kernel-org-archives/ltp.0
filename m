From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Nov 2018 11:25:39 +0100
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <7cd10b3c-3127-f6eb-0b95-0b9b42b5a77a@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
 <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com>
 <20181105094005.GA8687@rei>
 <7cd10b3c-3127-f6eb-0b95-0b9b42b5a77a@google.com>
Message-ID: <20181106102538.GA13657@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Ok, so my test cases are using arrays on the stack dimensioned at 
> run-time based on other values computed at run time. C99 is needed for 
> that. I don't see any value in changing them to use alloca(), its a 
> waste of time.

That is not true, at least for gcc variable arrays have been supported
as an extension in the default gnu89 mode for years now. I think that it
even predates the c99 standard, which is what I'm trying to explain for
quite some time now.

The only difference I'm aware of is how inline keyword behaves between
c99 and gnu89 mode, there may be some other minor differencies though.

The C accepted by default by a modern (10 years old+) compilers is much
closer than c99 than to the original c89.

Can we please stop this useless arguemnts and focus on the actual code
now?

-- 
Cyril Hrubis
chrubis@suse.cz
