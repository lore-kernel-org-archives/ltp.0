From: Ramon Pantin <pantin@google.com>
Date: Mon, 5 Nov 2018 10:35:17 -0800
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <20181105094005.GA8687@rei>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
 <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com> <20181105094005.GA8687@rei>
Message-ID: <7cd10b3c-3127-f6eb-0b95-0b9b42b5a77a@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ok, so my test cases are using arrays on the stack dimensioned at 
run-time based on other values computed at run time. C99 is needed for 
that. I don't see any value in changing them to use alloca(), its a 
waste of time.

Is it really going to be an issue if I use a feature of a 19 year old 
language?


On 11/05/2018 01:40 AM, Cyril Hrubis wrote:
> Hi!
>> Can you help me understand why you don't want to allow this test case to
>> make use of the C99 programming language?
>>
>> It is only a 19 year old standard.
>>
>> If there is a problem with C99 use, can you indicate that the problem is?
> What I'm trying to say is:
>
> * Reasonable recent compilers support c99 features without -c99
>    explicitelly passed on command line
>
> * It's a very bad idea to hardcode switches in random leaf Makefiles
>    as from maintenance point of view this is real disaster
>
> If we ever want to stick to some C standard it has to be a top level
> decision, but honestly I do prefer the compiler defaults.
>

