using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookShelf.WebApi.Infrastructure.Extensions
{
    public static class ControllerExtension
    {
        private static string RequestId = "RequestId";

        public static string GetRequestId(this ControllerBase controller)
        {
            if (!controller.HttpContext.Items.TryGetValue(RequestId, out object requestId))
            {
                requestId = Guid.NewGuid().ToString();
                controller.HttpContext.Items[RequestId] = requestId;
            }

            return requestId.ToString();
        }
    }
}
