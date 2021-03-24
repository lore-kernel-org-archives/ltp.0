From: Heiko Carstens <hca@linux.ibm.com>
Date: Wed, 24 Mar 2021 10:50:11 +0100
Subject: [LTP] [PATCH 1/3] s390/vdso: fix tod clock steering
In-Reply-To: <20210323215819.4161164-2-hca@linux.ibm.com>
References: <YFmUrVOyX4q+8Dy9@osiris>
 <20210323215819.4161164-1-hca@linux.ibm.com>
 <20210323215819.4161164-2-hca@linux.ibm.com>
Message-ID: <YFsLU2k/h3WPDrJz@osiris>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 23, 2021 at 10:58:17PM +0100, Heiko Carstens wrote:
> The s390 specific vdso function __arch_get_hw_counter() is supposed to
> consider tod clock steering.
> 
> If a tod clock steering event happens and the tod clock is set to a
> new value __arch_get_hw_counter() will not return the real tod clock
> value but slowly drift it from the old delta until the returned value
> finally matches the real tod clock value again.
> 
> When converting the assembler code to C it was forgotten to tell user
> space in which direction the clock has to be adjusted.
> 
> Worst case is now that instead of drifting the clock slowly it will
> jump into the opposite direction by a factor of two.
> 
> Fix this by simply providing the missing value to user space.
> 
> Fixes: 4bff8cb54502 ("s390: convert to GENERIC_VDSO")
> Cc: <stable@vger.kernel.org> # 5.10
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/time.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
> index 165da961f901..e37285a5101b 100644
> --- a/arch/s390/kernel/time.c
> +++ b/arch/s390/kernel/time.c
> @@ -382,6 +382,7 @@ static void clock_sync_global(unsigned long delta)
>  		      tod_steering_delta);
>  	tod_steering_end = now + (abs(tod_steering_delta) << 15);
>  	vdso_data->arch_data.tod_steering_end = tod_steering_end;
> +	vdso_data->arch_data.tod_steering_delta = tod_steering_delta;

..and yet another bug: __arch_get_hw_counter() tests if
tod_steering_delta is negative.
It makes sense to give tod_steering_delta the correct type:

diff --git a/arch/s390/include/asm/vdso/data.h b/arch/s390/include/asm/vdso/data.h
index 7b3cdb4a5f48..73ee89142666 100644
--- a/arch/s390/include/asm/vdso/data.h
+++ b/arch/s390/include/asm/vdso/data.h
@@ -6,7 +6,7 @@
 #include <vdso/datapage.h>
 
 struct arch_vdso_data {
-	__u64 tod_steering_delta;
+	__s64 tod_steering_delta;
 	__u64 tod_steering_end;
 };
 
