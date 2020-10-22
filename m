From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 22 Oct 2020 10:24:06 +0530
Subject: [LTP] [PATCH V4 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <20201021120434.GB10861@yuki.lan>
References: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
 <63646c1ba9e1a3061b44be4f1f9a29d9d6d03f2e.1603254560.git.viresh.kumar@linaro.org>
 <20201021120434.GB10861@yuki.lan>
Message-ID: <20201022045406.4m6pgqfmwvyx7mh2@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21-10-20, 14:04, Cyril Hrubis wrote:
> I guess that we still need a test where select would clear the bits from
> fd->set though, I supposes that the easiest solution would be to add
> select04.c for that...

I am not sure how to do that and why would that matter ? :)

-- 
viresh
