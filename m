From: Li Wang <liwang@redhat.com>
Date: Wed, 11 Mar 2020 21:11:00 +0800
Subject: [LTP] [PATCH V5 01/10] tst_device: Add tst_is_mounted() helper
In-Reply-To: <CAEemH2fqKvEU8+FBvTunv8VCOzXf0SMCHe6Ky9neFKQX51cZ7g@mail.gmail.com>
References: <cover.1582779464.git.viresh.kumar@linaro.org>
 <2071e47d7d8cb3e7f8bc6558e86999eddd9c3762.1582779464.git.viresh.kumar@linaro.org>
 <20200306124546.GA3375@rei.lan>
 <CAEemH2drJyp5kU21jS7Ej+-q6hTysb5oDNM+3KiWsmPoLAbMQA@mail.gmail.com>
 <20200311102620.GB3802@rei.lan>
 <CAEemH2fqKvEU8+FBvTunv8VCOzXf0SMCHe6Ky9neFKQX51cZ7g@mail.gmail.com>
Message-ID: <CAEemH2fqcnETtW47kB5BNGyf8_F11zD8Y_RpDaNOhSmEGHJYtA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 11, 2020 at 8:45 PM Li Wang <liwang@redhat.com> wrote:

> ...
>>
>> int tst_is_mntpoint_at_tmpdir(const char *path);
>>
>
> Hmm, the return value shouldn't the full right path, why return int here?
> or I misunderstand here?
>
>
s/shouldn't/should

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200311/538c16c8/attachment.htm>
