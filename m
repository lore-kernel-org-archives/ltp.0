From: Michael Moese <mmoese@suse.de>
Date: Fri, 12 Jan 2018 11:52:12 +0100
Subject: [LTP] [PATCH v2] Add regression test for CVE-2017-17052
In-Reply-To: <20180112104540.GA22350@rei>
References: <20180110155505.28433-1-mmoese@suse.de>
 <20180112104540.GA22350@rei>
Message-ID: <20180112105212.bkzxuhspnlgbg3x7@linux.suse>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi, 
> Apart from the SHM, that's already been commented here my only question
> is what is the outcome of the test on unpatched kernel? I suppose that
> we got TPASS when everything is going well, do we print the "something
> strange happened" message if the test fails, or does it fail elsewhere?

Well, on an unpatched kernel, it does not survive the test. In my QEMU 
testing, the kernel never survived this test until the end.
Unfortunately, I was not able to test for this CVE without risking a 
crash. 
That is the reason why there is no "the kernel is vulnerable" message.

Michael

-- 
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
