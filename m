From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Oct 2016 13:39:46 +0100
Subject: [LTP] typo in commit message
In-Reply-To: <20161010123034.GA1478@rei>
References: <20161010123034.GA1478@rei>
Message-ID: <CAFEAcA-Okz80wSDYmuhPvuV-ZJ9LzhknVmg4LMoeYs+8+zKR3g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10 October 2016 at 13:30, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> I've did a confusing typo in commit:
> https://github.com/linux-test-project/ltp/commit/ebfb34503c7928368043182a2ac7750e805c4911
>
> There is no such thing as ppc32le of course, it should have been
> ppc64le. Is everyone OK with me force pushing with the simple change in
> the commit message?

I would strongly recommend against it. Once a commit has
gone public to master, doing a force-push that rewrites
history will break things for people.

thanks
-- PMM
