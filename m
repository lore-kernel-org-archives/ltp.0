From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Jun 2019 18:49:11 +0300
Subject: [LTP] [PATCH v4] syscalls/sync_file_range: add partial file
	sync test-cases
In-Reply-To: <20190617150640.GD16831@rei>
References: <1560161596-30156-1-git-send-email-sumit.garg@linaro.org>
 <20190617150640.GD16831@rei>
Message-ID: <CAOQ4uxithmPn6J=B2kaGKT0JOpqzyVEkHU+zMqhXCYnnH+ZHVQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jun 17, 2019 at 6:06 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Pushed with following modifications, thanks.
>
> With these modification the test was stable and worked fine for more
> than 100 iterations for me. It still fails for FUSE based filesystems
> but that is to be expected since FUSE does not implement sync_file_range
> yet.
>

What is the proposed way to resolve this failure?
If FUSE does not implement sync_file_range, shouldn't test detect
it and return TCONF?

Thanks,
Amir.
