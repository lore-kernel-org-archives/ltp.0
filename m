From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 30 Jul 2021 13:43:49 +0200
Subject: [LTP] [PATCH v2] crypto/af_alg02: thread termination fixes
In-Reply-To: <668aa923-dda1-b3ce-8f5e-042e3a2174f5@jv-coder.de>
References: <20210720101249.10118-1-aleksei.kodanev@bell-sw.com>
 <YQPCcew5Are2VrDh@yuki>
 <0c978fd5-9772-ad4e-c14e-c8b4a8344506@jv-coder.de>
 <CAEemH2d8sHSWCAst9-q6KiKfJTSULYS8-KivWHrS04mR6ZXjzQ@mail.gmail.com>
 <668aa923-dda1-b3ce-8f5e-042e3a2174f5@jv-coder.de>
Message-ID: <YQPl9f6JYE8zlNrm@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > That should work but no precise log to indicate where goes wrong,
> > so I vote to go the loop way:).
> Does it really matter? The being stuck in the read does not seem to be 
> the failure case tested with this test. Otherwise it would TFAIL.
> Additionally the loop and "custom" timeout was only introduced at a 
> later stage of the test. Initially it relied on the default timeout 
> handling.
> If my assumption, that being stuck in the read is not the failure case 
> of this test, then your argument is invalid. Your argument would work for
> each and every line of code, that might be executed, when the timeout hits.

The top level in the test actually says that for some kernels the read()
does not return, which is a kernel bug so the test should report this
case as a failure as well and also the commit that fixes this should be
added to the tags structure.

-- 
Cyril Hrubis
chrubis@suse.cz
