From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Mar 2020 15:13:26 +0100
Subject: [LTP] [PATCH v2] uart: add uart testcase in kernel
 device-drivers
In-Reply-To: <CAF12kFuqJQmiZW+otpb9Hp37kqVis9UzkOKJTMKQWCPnH1nPoQ@mail.gmail.com>
References: <20200324121742.7130-1-gengcixi@gmail.com>
 <20200325102852.GD5404@yuki.lan> <20200325152821.GA21800@dell5510>
 <CAF12kFv0P4yTVVf-pfXOai8+3urEiWug_dbnTfAXpyfOvzi2ug@mail.gmail.com>
 <20200326070555.GA17560@dell5510>
 <CAF12kFuqJQmiZW+otpb9Hp37kqVis9UzkOKJTMKQWCPnH1nPoQ@mail.gmail.com>
Message-ID: <20200327141325.GA5525@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >Cyril already mentioned the need to use proper locks instead of sleep
> I have realized the sleep is not a good way , but I don't have any idea
> about the "proper locks"
> Can you give me some help?

I've just send a patchset that implements the serial test based on the
serialcheck C source code, please have a look at that patchset.

-- 
Cyril Hrubis
chrubis@suse.cz
