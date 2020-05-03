From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Sun, 3 May 2020 18:43:03 +1000
Subject: [LTP] [PATCH v2 4/4] syscalls/fanotify: Use fanotify_save_fid()
 helper
In-Reply-To: <20200502162744.9589-5-amir73il@gmail.com>
References: <20200502162744.9589-1-amir73il@gmail.com>
 <20200502162744.9589-5-amir73il@gmail.com>
Message-ID: <20200503084301.GA2080@morpheus.bobrowski.net>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, May 02, 2020 at 07:27:44PM +0300, Amir Goldstein wrote:
> Reduce some boiler plate code in FAN_REPORT_FID tests and
> save fid only once per object instead of once per expected event.
> 
> Suggested-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Nice, thanks for cleaning up those other tests too. Changes look fine
to me.

Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>

/M
