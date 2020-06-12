From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 12 Jun 2020 10:04:33 +0200
Subject: [LTP] [PATCH V2 2/2] syscalls/clock_gettime: Add test to check
 bug during successive readings
In-Reply-To: <20200612074009.t5ccj36nf7pd25sz@vireshk-i7>
References: <0f1cc05d6d79238ed94b93417f300e9a026a2063.1591864369.git.viresh.kumar@linaro.org>
 <cc75beb4074b62e94b8ac92cba17af41b8f5fbdc.1591864369.git.viresh.kumar@linaro.org>
 <CAK8P3a1VEj=QhvmeSpzA1GKLhg9isM106yW1trntNVTqP5UZQw@mail.gmail.com>
 <20200612074009.t5ccj36nf7pd25sz@vireshk-i7>
Message-ID: <CAK8P3a1aYf+jEEWbfjW0wv55U0UUv45occvxViMAu52J+OP_bQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jun 12, 2020 at 9:40 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 11-06-20, 15:05, Arnd Bergmann wrote:


> > When any of the variants (in particular vdso_clock_gettime64) don't
> > exist, I think you just need to continue without printing anything.
>
> That is exactly why we are looking for ENOSYS here. The other code
> (which you removed) explicitly sets the error to ENOSYS if
> clock_gettime64() or clock_gettime() vdso isn't available. And so we
> won't print an error here. Though the setup routine will print only
> once if the vdso wasn't available, as general information.

Ok, got it, I misread the != ENOSYS check for ==ENOSYS.

      Arnd
