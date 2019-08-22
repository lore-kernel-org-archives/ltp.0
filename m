From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Aug 2019 14:45:12 +0200
Subject: [LTP] (no subject)
In-Reply-To: <CAJwJstDWVJ8HG=Fe1VZtPDTAsCawfoKkdLAikFMQZ-hXhOprvA@mail.gmail.com>
References: <CAJwJstDWVJ8HG=Fe1VZtPDTAsCawfoKkdLAikFMQZ-hXhOprvA@mail.gmail.com>
Message-ID: <20190822124512.GB6325@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I want to ask if I can use ltp for stressing CPU and Memory with Linux OS?

What kind of stress do you have in mind?

I guess that for CPU stress something as compiling kernel in a loop with
large enough -j parameter will suffice.

There are some test for OOM and memory overcommit, these are part of the
mm runtest file.

> If the answer is yes, Can I get the detailed explanation about the hierachy
> of ltp because I think the document of ltp did not explain that.

Unforunately that part of LTP is undercommented, you have to mostly
explore on your own, sorry.

-- 
Cyril Hrubis
chrubis@suse.cz
