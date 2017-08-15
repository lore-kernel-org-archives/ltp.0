From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 13:06:48 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <a1f4e3bb-3b7d-c259-67d1-596ee6f2b142@linaro.org>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
 <20170811140905.GB3341@rei.lan>
 <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
 <20170811152855.GA14152@rei.lan>
 <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
 <20170814133351.GA11524@rei>
 <99937465-7b6b-ce2c-6194-bf920b2994f4@linaro.org>
 <20170814143609.GB11524@rei>
 <a1f4e3bb-3b7d-c259-67d1-596ee6f2b142@linaro.org>
Message-ID: <20170815110648.GC20715@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > And even if only subset of them fails I would still consider changing
> > the timer library rather than individual testcases.
> 
> Yes, that make sense.
> 
> Do you want keep the latency option for future use?

I tend not to add anything just in case that we may need it later in
order to keep the test library as small as possible, it's complex enough
even as it is. Moreover we can always add it easily when we find a test
that requires it.

-- 
Cyril Hrubis
chrubis@suse.cz
