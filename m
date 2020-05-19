From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 19 May 2020 16:35:25 +0200
Subject: [LTP] [PATCH 1/1] C API: Turn .test_variants into array of
 description
In-Reply-To: <20200519140704.GE16008@yuki.lan>
References: <20200519120725.25750-1-pvorel@suse.cz>
 <20200519140704.GE16008@yuki.lan>
Message-ID: <20200519143525.GA8076@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> I do not think that having more ifdefs and splitting the test variant
> structure helps to make things simple in the case of timer testcases.

> What exact problem are you trying to solve?
Well, no real problem, just less code in tests.
OK, let's drop this attempt.

Kind regards,
Petr
