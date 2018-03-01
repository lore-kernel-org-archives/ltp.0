From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 1 Mar 2018 18:28:35 +0300
Subject: [LTP] [PATCH] netstress: set port dynamically on the server-side
In-Reply-To: <20180227070942.GD876@x230>
References: <1518777047-24192-1-git-send-email-alexey.kodanev@oracle.com>
 <20180227070942.GD876@x230>
Message-ID: <8b0aa2b7-9d24-7fa0-0aac-6f923004070a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/27/2018 10:09 AM, Petr Vorel wrote:
... 
>> +static void move_to_background(void)
>> +{
>> +	if (SAFE_FORK())
>> +		exit(0);
>> +
>> +	SAFE_SETSID();
>> +
>> +	close(0);
>> +	SAFE_OPEN("/dev/null", O_RDONLY);
>> +
>> +	close(1);
>> +	close(2);
> Minor nit: maybe using STDIN_FILENO, STDOUT_FILENO, STDERR_FILENO is "correct way", but everyone
> knows these numbers.

Corrected and applied the patch.

Thanks,
Alexey
