From: Ramon Pantin <pantin@google.com>
Date: Sat, 3 Nov 2018 15:18:52 -0700
Subject: [LTP] recvmmsg(2) system call tests
In-Reply-To: <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com>
References: <ecdea1f2-4931-5dc3-6695-4f8dd78d796d@google.com>
 <20181101113857.GB22042@dell5510>
 <3C276F4D-DC1A-4CB6-A5BC-BBC6B07E23A6@google.com>
 <20181102105206.GA22411@rei>
 <c5eb4e3a-a164-d207-ccee-f84b10d51ec6@google.com>
Message-ID: <821f9b35-ee0f-f2ba-cb9f-2aa64ed0bd75@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Pardon the typo, can you indicate *what* the problem is with using C99.

On 11/03/18 15:16, Ramon Pantin wrote:
> Cyril,
>
> Can you help me understand why you don't want to allow this test case 
> to make use of the C99 programming language?
>
> It is only a 19 year old standard.
>
> If there is a problem with C99 use, can you indicate that the problem is?
>
> thank you,
> Ramon
>
> On 11/02/18 03:52, Cyril Hrubis wrote:
>> Actually the default for gcc is gnu90 which is close to c99 anyways, so
>> we do not have to do anything about it.
>

