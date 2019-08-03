From: Li Wang <liwang@redhat.com>
Date: Sat, 3 Aug 2019 21:02:06 +0800
Subject: [LTP] [RFC PATCH 2/9] lib: Add a canary for guarded buffers
In-Reply-To: <20190801092616.30553-3-chrubis@suse.cz>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-3-chrubis@suse.cz>
Message-ID: <CAEemH2d8dEe0km7FA43S2eQYHE00m9advsAbUbmFfixcV0-qhw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Aug 1, 2019 at 5:26 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> In a case that the buffer size is not a multiple of a page size there is
> unused space before the start of the buffer. Let's fill that with
> center mirrored random bytes and check that the buffer wasn't modified
> before we unmap it.

I like this check canary part. Amazing to me.

> +
> +static void check_canary(struct map *map)
> +{
> +       size_t i;
> +       char *buf = map->addr;
> +
> +       for (i = 0; i < map->buf_shift/2; i++) {
> +               if (buf[map->buf_shift - i - 1] != buf[i]) {
> +                       tst_res(TWARN,
> +                               "pid %i: buffer modified before address %p %zu",
> +                               (char*)map->addr + map->buf_shift, i);

Here you probably missed the getpid() for printing %i match :).

-- 
Regards,
Li Wang
